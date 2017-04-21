/**
 * Created by joab on 04/07/16.
 */


$(document).ready(function() {

    var f_rif = true;
    var f_fname = true;
    var f_lname = true;
    var f_adress = true;
    var f_cant1 = false;
    var f_cant2 = false;
    var f_cant3 = false;
    var f_cant4 = false;
    var f_cant5 = false;
    var f_nfac = false;

    var regexNum = /^([\d]*)$/;
    var regexCant = /^([\.\d]*)$/;
    var regexName = /^[A-Za-zÁáÉéÍíÓóÚúÜüÑñ'\s]{2,50}$/;
    var regexAdress = /^([A-Za-zÁáÉéÍíÓóÚúÜüÑñ#,-\.\d\s]{5,100})$/;

    //Campos Numericos
    $('.val_rif').numeric();
    $('.val-cant').numeric();
    $('#inp_nunfac').numeric();

    //Validacion del campo de RIF
    $('.val_rif').focus(function(){
        $(this).keyup(function(){
            $(this).removeClass('field-pass');
            $(this).removeClass('field-fail');
            if (($('#tipo-doc').val() === 'V' || $('#tipo-doc').val() === 'E') && $(this).val().length >= 6 && $(this).val().match(regexNum)) {
                $(this).addClass('field-pass');
            }else if (($('#tipo-doc').val() === 'J' || $('#tipo-doc').val() === 'G') && $(this).val().length >= 9 && $(this).val().match(regexNum)) {
                $(this).addClass('field-pass');
            }else if ($(this).val() === '') {
                $(this).removeClass('field-pass');
                $(this).removeClass('field-fail');
            }else {
                $(this).addClass('field-fail');
            }
        });
    });

    //Validacion del campo de Tipo de documento
    $("#tipo-doc").change(function(){
        $('.val_rif').removeClass('field-pass');
        $('.val_rif').removeClass('field-fail');
        if (($('#tipo-doc').val() === 'V' || $('#tipo-doc').val() === 'E') && $('.val_rif').val().length >= 6 && $('.val_rif').val().match(regexNum)) {
            $('.val_rif').addClass('field-pass');
        }else if (($('#tipo-doc').val() === 'J' || $('#tipo-doc').val() === 'G') && $('.val_rif').val().length >= 9 && $('.val_rif').val().match(regexNum)) {
            $('.val_rif').addClass('field-pass');
        }else if ($('.val_rif').val() === '') {
            $('.val_rif').removeClass('field-pass');
            $('.val_rif').removeClass('field-fail');
        }else {
            $('.val_rif').addClass('field-fail');
        }
    });

    //Validacion de los campos de nombre
    $('.val-name').focus(function(){
        $(this).keyup(function(){
            $(this).removeClass('field-pass');
            $(this).removeClass('field-fail');
            if ($(this).val().length >= 2 && $(this).val().match(regexName)) {
                $(this).addClass('field-pass');
            }else if ($(this).val() === '') {
                $(this).removeClass('field-pass');
                $(this).removeClass('field-fail');
            }else {
                $(this).addClass('field-fail');
            }
        });
    });

    //Validacion del campo de direccion
    $('.val-adress').focus(function(){
        $(this).keyup(function(){
            $(this).removeClass('field-pass');
            $(this).removeClass('field-fail');
            if ($(this).val().length >= 5 && $(this).val().match(regexAdress)) {
                $(this).addClass('field-pass');
            }else if ($(this).val() === '') {
                $(this).removeClass('field-pass');
                $(this).removeClass('field-fail');
            }else {
                $(this).addClass('field-fail');
            }
        });
    });

    //Validacion de los campos de cantidad
    $('.val-cant').focus(function(){
        $(this).keyup(function(){
            $(this).removeClass('field-pass');
            $(this).removeClass('field-fail');
            if ($(this).val().length >= 1 && $(this).val().match(regexCant)) {
                $(this).addClass('field-pass');
            }else if ($(this).val() === '') {
                $(this).removeClass('field-pass');
                $(this).removeClass('field-fail');
            }else {
                $(this).addClass('field-fail');
            }
        });
    });

    //Validacion de productos seleccionados
    $('.val_prod').click(function(){
        if ($('.dataTables_empty').length) {
            $('.confirm').prop('disabled', true);
            $('.confirm').removeClass('primary');
            $('#search-info').hide();
            $('#impress-warn').hide();
            $('#confirm-err').show();
            setTimeout(function(){
                $('#confirm-err').hide();
            }, 5000);
        }else {
            $('.confirm').prop('disabled', false);
            $('.confirm').addClass('primary');
        }
        activaBoton();
    });

    //Validacion de botones
    $('.val_btn').click(function(){
        if ($('.dataTables_empty').length) {
            $.Notify({
                caption: 'Error',
                content: 'Debe seleccionar un producto para utilizar esta opción',
                type: 'alert',
                shadow: true,
                timeout: 5000
            });
        } else {
            $('.add_modi').click(function() {
                if (!$('.selected').length) {
                    $.Notify({
                        caption: 'Error',
                        content: 'Debe seleccionar un producto para utilizar esta opción',
                        type: 'alert',
                        shadow: true,
                        timeout: 5000
                    });
                }
            });
        }
    });

    //#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#\\

    $('#inp_rif').focus(function(){
        $(this).keyup(function(){
            console.log("estoy en rif");
            if (($('#tipo-doc').val() === 'V' || $('#tipo-doc').val() === 'E') && $(this).val().length >= 6 && $(this).val().match(regexNum)) {
                f_rif = true;
            } else if (($('#tipo-doc').val() === 'J' || $('#tipo-doc').val() === 'G') && $(this).val().length >= 9 && $(this).val().match(regexNum)) {
                f_rif = true;
            } else if ($(this).val() === '') {
                f_rif = true;
            } else {
                f_rif = false;
            }
            activaBoton();
        });
    });

    $("#tipo-doc").change(function(){
        if (($('#tipo-doc').val() === 'V' || $('#tipo-doc').val() === 'E') && $('.val_rif').val().length >= 6 && $('.val_rif').val().match(regexNum)) {
            f_rif = true;
        } else if (($('#tipo-doc').val() === 'J' || $('#tipo-doc').val() === 'G') && $('.val_rif').val().length >= 9 && $('.val_rif').val().match(regexNum)) {
            f_rif = true;
        } else if ($('.val_rif').val() === '') {
            f_rif = true;
        } else {
            f_rif = false;
        }
        activaBoton();
    });

    $('#inp_fname').focus(function(){
        $(this).keyup(function(){
            if ($(this).val().length >= 2 && $(this).val().match(regexName)) {
                f_fname = true;
            } else if ($(this).val() === '') {
                f_fname = true;
            } else {
                f_fname = false;
            }
            activaBoton();
        });
    });

    $('#inp_lname').focus(function(){
        $(this).keyup(function(){
            if ($(this).val().length >= 2 && $(this).val().match(regexName)) {
                f_lname = true;
            } else if ($(this).val() === '') {
                f_lname = true;
            } else {
                f_lname = false;
            }
            activaBoton();
        });
    });

    $('#inp_adress').focus(function(){
        $(this).keyup(function(){
            if ($(this).val().length >= 5 && $(this).val().match(regexAdress)) {
                f_adress = true;
            } else if ($(this).val() === '') {
                f_adress = true;
            } else {
                f_adress = false;
            }
            activaBoton();
        });
    });

    $('#inp_cant1').focus(function(){
        $(this).keyup(function(){
            if ($(this).val().length >= 1 && $(this).val().match(regexCant)) {
                f_cant1 = true;
            } else if ($(this).val() === '') {
                f_cant1 = true;
            } else {
                f_cant1 = false;
            }
            activaBoton();
        });
    });

    $('#inp_cant2').focus(function(){
        $(this).keyup(function(){
            if ($(this).val().length >= 1 && $(this).val().match(regexCant)) {
                f_cant2 = true;
            } else if ($(this).val() === '') {
                f_cant2 = true;
            } else {
                f_cant2 = false;
            }
            activaBoton();
        });
    });

    $('#inp_cant3').focus(function(){
        $(this).keyup(function(){
            if ($(this).val().length >= 1 && $(this).val().match(regexCant)) {
                f_cant3 = true;
            }
            else if ($(this).val() === '') {
                f_cant3 = true;
            }
            else { f_cant3 = false; }
            activaBoton();
        });
    });

    $('#inp_cant4').focus(function(){
        $(this).keyup(function(){
            if ($(this).val().length >= 1 && $(this).val().match(regexCant)) {
                f_cant4 = true;
            } else if ($(this).val() === '') {
                f_cant4 = true;
            } else {
                f_cant4 = false;
            }
            activaBoton();
        });
    });

    $('#inp_cant5').focus(function(){
        $(this).keyup(function(){
            if ($(this).val().length >= 1 && $(this).val().match(regexCant)) {
                f_cant5 = true;
            } else if ($(this).val() === '') {
                f_cant5 = true;
            } else {
                f_cant5 = false;
            }
            activaBoton();
        });
    });

    function activaBoton() {
        if (
            (f_rif === true && f_fname === true && f_lname === true && f_adress === true)
            &&
            (f_cant1 === true || f_cant2 === true || f_cant3 === true || f_cant4 === true || f_cant5 === true)
            &&
            ($('#inp_cant1').val().length >= 1 || $('#inp_cant2').val().length >= 1 || $('#inp_cant3').val().length >= 1 || $('#inp_cant4').val().length >= 1 || $('#inp_cant5').val().length >= 1)
        ) {
            $('.confirm').prop('disabled', false);
            $('.confirm').addClass('primary');
        } else {
            $('.confirm').prop('disabled', true);
            $('.confirm').removeClass('primary');
        }
    }

    //#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#·#\\

    $('#btn_devolucion').click(function() {
        activaBotonDev();
    });

    //Validacion del campo de numero de factura
    $('.val-nfac').focus(function(){
        $(this).keyup(function(){
            $(this).removeClass('field-pass');
            $(this).removeClass('field-fail');
            if ($(this).val().length >= 1 && $(this).val().match(regexNum)) {
                $(this).addClass('field-pass');
            }else if ($(this).val() === '') {
                $(this).removeClass('field-pass');
                $(this).removeClass('field-fail');
            }else {
                $(this).addClass('field-fail');
            }
        });
    });

    /*$('#inp_nunfac').focus(function(){
     $(this).keyup(function(){
     if ($(this).val().length >= 1 && $(this).val().match(regexNum)) {
     f_nfac = true;
     } else if ($(this).val() === '') {
     f_nfac = false;
     } else {
     f_nfac = false;
     }
     activaBotonDev();
     });
     });*/

    function activaBotonDev() {
        if (f_nfac === true)
        {
            $('.confirm-dev').prop('disabled', false);
            $('.confirm-dev').addClass('primary');
        } else {
            $('.confirm-dev').prop('disabled', true);
            $('.confirm-dev').removeClass('primary');
        }
    }

});