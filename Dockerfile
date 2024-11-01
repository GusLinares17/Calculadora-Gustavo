# Usa una imagen base de Perl
FROM perl:5.32

# Instala Apache y módulos necesarios
RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-perl2 && \
    cpan install CGI

# Habilita el módulo CGI
RUN a2enmod cgi

# Configura ServerName para evitar advertencias
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Configura el directorio CGI en Apache
RUN echo "<Directory \"/usr/lib/cgi-bin\">\n\
AllowOverride None\n\
Options +ExecCGI\n\
AddHandler cgi-script .pl\n\
Require all granted\n\
</Directory>" >> /etc/apache2/apache2.conf

# Copia los archivos HTML y CSS en el directorio adecuado
COPY html/ /var/www/html/
COPY css/ /var/www/html/css/

# Copia el script Perl en el directorio CGI
COPY cgi-bin/ /usr/lib/cgi-bin/
RUN chmod +x /usr/lib/cgi-bin/*.pl

# Exponer el puerto 80
EXPOSE 80

# Iniciar Apache en modo foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
