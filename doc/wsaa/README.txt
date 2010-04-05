Web Service de Autenticación y Autorización (WSAA)


Con respecto al WSAA, recomendamos leer el Manual para el Desarrollador en:

http://wswhomo.afip.gov.ar/fiscaldocs/WSAA/Especificacion_Tecnica_WSAA_1.2.0.pdf



Las URLs del WSAA son:
TESTING: https://wsaahomo.afip.gov.ar/ws/services/LoginCms
PRODUCCION: https://wsaa.afip.gov.ar/ws/services/LoginCms



Para poder autenticarse ante el WSAA necesita obtener un certificado digital 
X.509 emitido por la CA (Autoridad Certificante) de AFIP, a tales efectos, 
deberá generar una clave privada y un CSR (Certificate Signing Request). 
Deberá enviar el CSR, en el entorno de Testing a través de correo a la cuenta 
webservices@afip.gov.ar, y en el entorno de Producción a través de nuestro 
portal http://www.afip.gov.ar siguiendo los pasos indicados en el siguiente 
documento:

http://wswhomo.afip.gov.ar/wsfedocs/WSAA%20-%20Procedimiento%20obtencion%20y%20asociacion%20de%20certificados%20-%20090323.pdf


Para generar su clave privada y su CSR, recomendamos leer el siguiente howto:

http://wswhomo.afip.gov.ar/fiscaldocs/WSAA/cert-req-howto.txt



Tratando de simplificar el desarrollo del cliente consumidor del WSAA, hemos 
contribuido con ejemplos de código fuente abierto, que pueden ser utilizados
tal como están, o bien utilizarse como guía. Hemos contribuido con fuentes en 
VB.Net, en Java y en PHP. Los mismos pueden ser obtenidos desde:

http://wswhomo.afip.gov.ar/fiscaldocs/WSAA/ejemplos/

Aclaramos que estas contribuciones son solamente ejemplos, no asumimos ningun 
compromiso en cuanto a su funcionalidad ni incluyen ningun tipo de garantia ni
soporte tecnico.



Herramientas de Análisis / Depuración
Consultar el siguiente link:

http://wswhomo.afip.gov.ar/fiscaldocs/WSAA/HerramientasUtiles.pdf
