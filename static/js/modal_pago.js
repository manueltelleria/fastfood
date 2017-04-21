/**
 * Created by joab on 31/05/16.
 */

$(document).ready(function(){

    verify();

    $('#btn-plus').click(function(){
        if($('#uno').is(':hidden')) {
            $('#uno').show();
        }else if($('#dos').is(':hidden')) {
            $('#dos').show();
        }else if($('#tres').is(':hidden')) {
            $('#tres').show();
        }else if($('#cuatro').is(':hidden')) {
            $('#cuatro').show();
        }else if($('#cinco').is(':hidden')) {
            $('#cinco').show();
        }
        verify();
    });

    $('#btn-uno').click(function(){
        $('#uno').hide();
        verify();
    });
    $('#btn-dos').click(function(){
        $('#dos').hide();
        verify();
    });
    $('#btn-tres').click(function(){
        $('#tres').hide();
        verify();
    });
    $('#btn-cuatro').click(function(){
        $('#cuatro').hide();
        verify();
    });
    $('#btn-cinco').click(function(){
        $('#cinco').hide();
        verify();
    });

    function verify() {
        var count = 0;
        var a = false;
        var b = false;
        var c = false;
        var d = false;
        var e = false;

        if($('#uno').is(':visible')) {
            count += 1;
            a = true;
        }
        if($('#dos').is(':visible')) {
            count += 1;
            b = true;
        }
        if($('#tres').is(':visible')) {
            count += 1;
            c = true;
        }
        if($('#cuatro').is(':visible')) {
            count += 1;
            d = true;
        }
        if($('#cinco').is(':visible ')) {
            count += 1;
            e = true;
        }

        if (count === 5) {
            $('#btn-plus').prop('disabled', true);
            $('#btn-plus').removeClass('success');
        }else if (count === 1) {
            if (a) {
                $('#btn-uno').prop('disabled', true);
                $('#btn-uno').removeClass('danger');
            }else if (b) {
                $('#btn-dos').prop('disabled', true);
                $('#btn-dos').removeClass('danger');
            }else if (c) {
                $('#btn-tres').prop('disabled', true);
                $('#btn-tres').removeClass('danger');
            }else if (d) {
                $('#btn-cuatro').prop('disabled', true);
                $('#btn-cuatro').removeClass('danger');
            }else if (e) {
                $('#btn-cinco').prop('disabled', true);
                $('#btn-cinco').removeClass('danger');
            }
        }else {
            $('#btn-plus').prop('disabled', false);
            $('#btn-plus').addClass('success');
            $('#btn-uno').prop('disabled', false);
            $('#btn-uno').addClass('danger');
            $('#btn-dos').prop('disabled', false);
            $('#btn-dos').addClass('danger');
            $('#btn-tres').prop('disabled', false);
            $('#btn-tres').addClass('danger');
            $('#btn-cuatro').prop('disabled', false);
            $('#btn-cuatro').addClass('danger');
            $('#btn-cinco').prop('disabled', false);
            $('#btn-cinco').addClass('danger');
        }
    }

});