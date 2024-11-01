#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use utf8;

my $cgi = CGI->new;

# Imprimir el encabezado de tipo de contenido
print $cgi->header('text/html; charset=UTF-8');

# Capturar la expresión ingresada
my $expresion = $cgi->param('expresion') // '';

# Inicializar variable para el resultado
my $resultado;

# Verificar si se ingresó una expresión válida y evaluarla
if ($expresion ne '') {
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

# Generar la página HTML con el resultado
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

# Mostrar el resultado o el mensaje adecuado
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
