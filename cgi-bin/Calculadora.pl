#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use utf8;

my $cgi = CGI->new;

sub manejar_calculo {
    my $expresion = $cgi->param('expresion') // '';  
    my $resultado;

    if ($expresion) {
        
        if ($expresion =~ /^[\d\+\-\*\/\(\) ]+$/) {
            
            eval {
                $resultado = eval $expresion;
            };
            
            if ($@) {
                $resultado = "Hubo un error en la expresión: $@";
            }
        } else {
            $resultado = "Expresión inválida. Solo se permiten números y los operadores +, -, *, /.";
        }
    } else {
        $resultado = "No se ingresó ninguna expresión.";
    }

    return generar_pagina($expresion, $resultado);
}


