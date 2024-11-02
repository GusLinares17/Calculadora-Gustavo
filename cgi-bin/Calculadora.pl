#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;
use CGI;
binmode(STDOUT, ":encoding(UTF-8)");

my $cgi = CGI->new;

print $cgi->header(-type => "text/html", -charset => "UTF-8");

my $expresion = $cgi->param('expresion') // '';
my $resultado = '';

if ($expresion ne '') {
    if ($expresion =~ /^[\d\+\-\*\/\(\) ]+$/) {
        eval {
            $resultado = eval $expresion;
        };
        if ($@) {
            $resultado = "Expresión incorrecta";
        }
    } else {
        $resultado = "Expresión incorrecta";
    }
}

print <<HTML;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Calculadora</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="calculator-container">
        <h1>Calculadora</h1>
        <form action="/cgi-bin/Calculadora.pl" method="post">
            <input type="text" name="expresion" placeholder="Ingrese expresión" value="$expresion" required>
            <input type="text" name="resultado" placeholder="Resultado" value="$resultado" readonly>
            <button type="submit">Calcular</button>
        </form>
    </div>
</body>
</html>
HTML
