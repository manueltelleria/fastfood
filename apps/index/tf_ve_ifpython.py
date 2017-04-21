# -*- coding: iso-8859-1 -*-

import serial
import operator
import sys
import time
import glob
import os

class tf_ve_ifpython:
	bandera=False
	mdepura=False
	status =''
	envio  =''
	error  =''

#Funcion ABRIR
	def OpenFpctrl(self, p):
		if not self.bandera:
			try:
				self.ser= serial.Serial(port=p, 
				baudrate=9600,
				bytesize=serial.EIGHTBITS,
				parity=serial.PARITY_EVEN,
				stopbits=serial.STOPBITS_ONE,
				timeout =1.5,
				writeTimeout=5,
				xonxoff=0,
				rtscts=0)
				self.bandera=True
				return True
			except (serial.portNotOpenError, serial.SerialTimeoutException):
				self.bandera=False
				self.envio = "Impresora no conectada o error accediendo al puerto" + str(p)
				return False

#Funcion CERRAR
	def CloseFpctrl(self):
		if self.bandera:
			self.ser.close()
			self.bandera=False
			return self.bandera

#Funcion MANIPULA
	def ManipulaCTS_RTS(self):
		try:
			self.ser.setRTS(True)
			lpri=1
			while not self.ser.getCTS():
				time.sleep(lpri/10)
				lpri=lpri+1
				if lpri>20:
					self.ser.setRTS(False)
					return False
			return True
		except serial.SerialException:
			return False

	def SimpleCmd(self,cmd):
		try:
			self.ser.flushInput()
			self.ser.flushOutput()
			if self.ManipulaCTS_RTS():
				msj=self.qenviar(cmd)
				self._write(msj)
				rt=self._read(1)
				if rt==chr(0x06):
					self.envio = "Status: 00  Error: 00"
					rt=True
				else:
					self.envio = "Status: 00  Error: 89"
					rt=False
			else:
				self.DarStatus_Error(0, 128);
				self.envio = "Error... CTS in False"
				rt=False
			self.ser.setRTS(False)
		except serial.SerialException:
			rt=False
		return rt

	def SendFileCmd(self, f):
		for linea in f:
                        if (linea!=""):
                                print linea
                                self.SimpleCmd(linea)

        def QueryCmd(self,cmd):
		try:
			self.ser.flushInput()
			self.ser.flushOutput()
			if self.ManipulaCTS_RTS():
				msj=self.qenviar(cmd)
				self._write(msj)
				rt=True
			else:
				self.DarStatus_Error(0, 128);
				self.envio = "Error... CTS in False"
				rt=False
			self.ser.setRTS(False)
		except serial.SerialException:
			rt=False
		return rt

	def FecthRow(self):
		while True:
			time.sleep(1)
			bytes = self.ser.inWaiting()
			if bytes>1:
				msj=self._read(bytes)
				linea=msj[1:-1]
				lrc=chr(self.lrc(linea))
				if lrc==msj[-1]:
					self.ser.flushInput()
					self.ser.flushOutput()
					return msj
				else:
					break
			else:
				break
		return None


	def ReadFpStatus(self):
		if self.ManipulaCTS_RTS():
			msj=chr(0x05)
			self._write(msj)
			time.sleep(0.05)
			#bytes = self.ser.inWaiting()
			r=self._read(5)
			if len(r)==5:
				if ord(r[1])^ord(r[2])^0x03 == ord(r[4]):
					return self.DarStatus_Error(ord(r[1]), ord(r[2]))
				else:
					return self.DarStatus_Error(0, 144)
			else:
##				self.estado = "Impresora ocupada";
				return self.DarStatus_Error(0, 114)
		else:
			return self.DarStatus_Error(0, 128);
##			self.estado = "Error... CTS in False";

	def _write(self,msj):
		if self.mdepura:
			print '<<< '+self.depura(msj)
		self.ser.write(msj)

	def _read(self,bytes):
		msj = self.ser.read(bytes)
		if self.mdepura:
			print '>>> '+self.depura(msj)
		return msj

	def qenviar(self,linea):
		lrc = self.lrc(linea+chr(0x03))
		previo=chr(0x02)+linea+chr(0x03)+chr(lrc)
		return previo

	def lrc(self,linea):
		return reduce(operator.xor, map(ord, linea))

	def depura(self,linea):
		if linea!=None:
			if len(linea)==0:
				return 'null'
			if len(linea)>3:
				lrc=linea[-1]
				linea=linea[0:-1]
				adic=' LRC('+str(ord(lrc))+')'
			else:
				adic=''
			linea=linea.replace('STX',chr(0x02),1)
			linea=linea.replace('ENQ',chr(0x05),1)
			linea=linea.replace('ETX',chr(0x03),1)
			linea=linea.replace('EOT',chr(0x04),1)
			linea=linea.replace('ACK',chr(0x06),1)
			linea=linea.replace('NAK',chr(0x15),1)
			linea=linea.replace('ETB',chr(0x17),1)

		return linea+adic

	def estados1(self, cmd):
		if self.QueryCmd(cmd):
			msj=1
			while True:
				msj=self.FecthRow()
				if msj==None:
					break
				msj=msj[1:-2]
				m=msj.split(chr(10))
				if len(m)>=9:
					return m
		return None

	def estados2(self, cmd):
		if self.QueryCmd(cmd):
			m=0 #msj=1
			while True:
				msj=self.FecthRow()
				if msj==None:
					break
				msj=msj[1:-2]
				m=msj.split(chr(10))
				if len(m)>=9:
					return m
		return m

	def estados3(self, cmd):
		if self.QueryCmd(cmd):
			m=1 #msj=0
			while True:
				msj=self.FecthRow()
				if msj==None:
					break
				msj=msj[1:-2]
				m=msj.split(chr(1))
				if len(m)>=9:
					return m
		return m

	def updateReport(self, cmd):
		try:
			self.ser.flushInput()
			self.ser.flushOutput()
			if self.ManipulaCTS_RTS():
                                msj=1
				msj=self.qenviar(cmd)
				self._write(msj)
				rt=self._read(1)
				while True:
##				        if rt==chr(0x05):
                                    if (self._read(1)):
                                        time.sleep(0.05)
                                        msj=self.depura('ACK')
                                        self._write(msj)
                                        time.sleep(0.05)
                                        msj=self.FecthRow()
                                        #msj=msj[1:-2]
                                        m=msj.split(chr(10))
                                        return m #sj #m
##				else:
##					#self.envio = "Status: 00  Error: 89"
##					return None
			else:
				self.DarStatus_Error(0, 128);
				self.envio = "Error... CTS in False"
				rt=None
			self.ser.setRTS(False)
		except serial.SerialException:
			rt=None
		return rt

	def updateLecturaMemFisc(self, cmd):
		try:
			self.ser.flushInput()
			self.ser.flushOutput()
			if self.ManipulaCTS_RTS():
                                msj=""
                                m=""
                                #i=0
				msj=self.qenviar(cmd)
				self._write(msj)
				rt=self._read(1)
				while True:
##				        if rt==chr(0x05):
                                    variable="mm"
                                    #print variable
                                    arreglodemsj=[]
                                    while variable!=None: #self.FecthRow()!=chr(0x04) or self.FecthRow()!='EOT': #self._read(1)!=chr(0x04) or self._read(1)!='EOT':
                                        time.sleep(0.5) #Espera
                                        msj=self.depura('ACK')
                                        self._write(msj)
                                        time.sleep(0.5) #Espera
                                        msj=self.FecthRow()
                                        variable=msj
                                        #print i
                                        arreglodemsj.append(msj)
                                        #print "msjacumulado", arreglodemsj #i+=1
                                        #print "I incrementado", i
                                        #m+=msj
                                        #msj=""
                                        #print msj
                                    #print "Este es el M enviado", m
                                    #break
                                    return arreglodemsj
                                    break                                  

			else:
				self.DarStatus_Error(0, 128);
				self.envio = "Error... CTS in False"
				m=None
			self.ser.setRTS(False)
		except serial.SerialException:
			m=None
		return m

	def updateLecturaMemFisc2(self, cmd):
		try:
			self.ser.flushInput()
			self.ser.flushOutput()
			if self.ManipulaCTS_RTS():
                                msj=""
                                m=""
                                #i=0
				msj=self.qenviar(cmd)
				self._write(msj)
				rt=self._read(1)
				while rt!=chr(0x05):
                                        #print rt
                                        rt=self._read(1)
				while True:
                                    variable="mm"
                                    print variable
                                    arreglodemsj=[]
                                    while variable!= None: #chr(0x04): #self.FecthRow()!=chr(0x04) or self.FecthRow()!='EOT': #self._read(1)!=chr(0x04) or self._read(1)!='EOT':
                                        time.sleep(0.5) #Espera
                                        msj=self.depura('ACK')
                                        self._write(msj)
                                        time.sleep(0.5) #Espera
                                        msj=self.FecthRow()
                                        variable=msj
                                        #print i
                                        arreglodemsj.append(msj)
                                        #print "msjacumulado", arreglodemsj #i+=1
                                        #print "I incrementado", i
                                        #m+=msj
                                        #msj=""
                                        #print msj
                                    #print "Este es el M enviado", m
                                    #break
                                    return arreglodemsj
                                    break                                  

			else:
				self.DarStatus_Error(0, 128);
				self.envio = "Error... CTS in False"
				m=None
			self.ser.setRTS(False)
		except serial.SerialException:
			m=None
		return m


	def DarStatus_Error(self,st,er):
		st_aux = st;
		st = st & ~0x04

		if   (st & 0x6A) == 0x6A: #En modo fiscal, carga completa de la memoria fiscal y emisión de documentos no fiscales
			self.status='En modo fiscal, carga completa de la memoria fiscal y emisión de documentos no fiscales'
			status = "12"
		elif (st & 0x69) == 0x69: #En modo fiscal, carga completa de la memoria fiscal y emisión de documentos  fiscales
			self.status='En modo fiscal, carga completa de la memoria fiscal y emisión de documentos  fiscales'
			status = "11"
		elif (st & 0x68) == 0x68: #En modo fiscal, carga completa de la memoria fiscal y en espera
			self.status='En modo fiscal, carga completa de la memoria fiscal y en espera'
			status = "10"
		elif (st & 0x72) == 0x72: #En modo fiscal, cercana carga completa de la memoria fiscal y en emisión de documentos no fiscales
			self.status='En modo fiscal, cercana carga completa de la memoria fiscal y en emisión de documentos no fiscales'
			status = "9 "
		elif (st & 0x71) == 0x71: #En modo fiscal, cercana carga completa de la memoria fiscal y en emisión de documentos no fiscales
			self.status='En modo fiscal, cercana carga completa de la memoria fiscal y en emisión de documentos no fiscales'
			status = "8 "
		elif (st & 0x70) == 0x70: #En modo fiscal, cercana carga completa de la memoria fiscal y en espera
			self.status='En modo fiscal, cercana carga completa de la memoria fiscal y en espera'
			status = "7 "
		elif (st & 0x62) == 0x62: #En modo fiscal y en emisión de documentos no fiscales
			self.status='En modo fiscal y en emisión de documentos no fiscales'
			status = "6 "
		elif (st & 0x61) == 0x61: #En modo fiscal y en emisión de documentos fiscales
			self.status='En modo fiscal y en emisión de documentos fiscales'
			status = "5 "
		elif (st & 0x60) == 0x60: #En modo fiscal y en espera
			self.status='En modo fiscal y en espera'
			status = "4 "
		elif (st & 0x42) == 0x42: #En modo prueba y en emisión de documentos no fiscales
			self.status='En modo prueba y en emisión de documentos no fiscales'
			status = "3 "
		elif (st & 0x41) == 0x41: #En modo prueba y en emisión de documentos fiscales
			self.status='En modo prueba y en emisión de documentos fiscales'
			status = "2 "
		elif (st & 0x40) == 0x40: #En modo prueba y en espera
			self.status='En modo prueba y en espera'
			status = "1 "
		elif (st & 0x00) == 0x00: #Status Desconocido
			self.status='Status Desconocido'
			status = "0 "

		if   (er & 0x6C) == 0x6C: #Memoria Fiscal llena
			self.error = 'Memoria Fiscal llena'
			error = "108"
		elif (er & 0x64) == 0x64: #Error en memoria fiscal
			self.error = 'Error en memoria fiscal'
			error = "100"
		elif (er & 0x60) == 0x60: #Error Fiscal
			self.error = 'Error Fiscal'
			error = "96 "
		elif (er & 0x5C) == 0x5C: #Comando Invalido
			self.error = 'Comando Invalido'
			error = "92 "
		elif (er & 0x58) == 0x58: # No hay asignadas  directivas
			self.error = 'No hay asignadas  directivas'
			error = "88 "
		elif (er & 0x54) == 0x54: #Tasa Invalida
			self.error = 'Tasa Invalida'
			error = "84 "
		elif (er & 0x50) == 0x50: #Comando Invalido/Valor Invalido
			self.error = 'Comando Invalido/Valor Invalido'
			error = "80 "
		elif (er & 0x43) == 0x43: #Fin en la entrega de papel y error mecánico
			self.error = 'Fin en la entrega de papel y error mecánico'
			error = "3  "
		elif (er & 0x42) == 0x42: #Error de indole mecanico en la entrega de papel
			self.error = 'Error de indole mecanico en la entrega de papel'
			error = "2  "
		elif (er & 0x41) == 0x41: #Fin en la entrega de papel
			self.error = 'Fin en la entrega de papel'
			error = "1  "
		elif (er & 0x40) == 0x40: #Sin error
			self.error = 'Sin error'
			error = "0  "

		if (st_aux & 0x04) == 0x04: #Buffer Completo
			self.error = ''
			error = "112 "
		elif er == 128:     # Error en la comunicacion
			self.error = 'CTS en falso'
			error = "128 ";
		elif er == 137:     # No hay respuesta
			self.error = 'No hay respuesta'
			error = "137 ";
		elif er == 144:     # Error LRC
			self.error = 'Error LRC'
			error = "144 ";
		elif er == 114:
			self.error = 'Impresora no responde o ocupada'
			error = "114 ";


##		return status+"   "+error
		return status+"   " +error+"   " +self.error
