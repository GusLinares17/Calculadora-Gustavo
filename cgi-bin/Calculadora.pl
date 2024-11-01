#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;
use CGI;
binmode(STDOUT, ":encoding(UTF-8)");

my $cgi = CGI->new;

print $cgi->header(-type => "text/html", -charset => "UTF-8");

my $expresion = $cgi->param('expresion') // '';
my $resultado;

if (defined $expresion && $expresion ne '') {
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
    $resultado = "Por favor, ingrese una expresión.";
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
            <button type="submit">Calcular</button>
        </form>
HTML

if (defined $resultado) {
    print "<h2>Resultado: $resultado</h2>";
}

print <<HTML;
        <footer>
            <p>Desarrollado por Gustavo Linares Aquino &copy; 2024 - Programación Web</p>
        </footer>
    </div>
</body>
</html>
HTML

