#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use utf8;

my $cgi = CGI->new;

print $cgi->header('text/html; charset=UTF-8');

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
sub generar_pagina {
    my ($expresion, $resultado) = @_;

    # Generar encabezado y estructura de la página
    print $cgi->header('text/html; charset=UTF-8');
    print "<!DOCTYPE html>";
    print "<html lang=\"es\">";
    print "<head>";
    print "<title>Calculadora</title>";
    print "<meta charset=\"UTF-8\">";
    print "<link rel=\"stylesheet\" href=\"../css/style.css\">";
    print "</head>";
    print "<body>";

    print "<div class=\"calculator-container\">";
    print "<h1>Calculadora</h1>";
    print "<form action=\"/cgi-bin/Calculadora.pl\" method=\"post\">";
    print "<input type=\"text\" name=\"expresion\" placeholder=\"Ingrese expresión\" value=\"" . $expresion . "\" required>";
    print "<button type=\"submit\">Calcular</button>";
    print "</form>";

    if ($resultado) {
        print "<h2>Resultado: $resultado</h2>";
    }

    print "<footer>";
    print "<p>Desarrollado por Gustavo Linares Aquino &copy; 2024 - Programación Web</p>";
    print "</footer>";
    print "</div>";

    print "</body>";
    print "</html>";
}

manejar_calculo();


