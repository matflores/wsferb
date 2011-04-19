.. index:: certificado digital: obtención

Obtención del certificado digital
=================================

Para obtener su :term:`certificado digital`, necesita el utilitario **OpenSSL**.
Si tiene acceso a un equipo Unix/Linux, seguramente ya lo tiene instalado.
Si sólo tiene acceso a equipos Windows, puede descargar **OpenSSL** desde aquí_.

.. _aquí: http://www.slproweb.com/products/Win32OpenSSL.html

Los pasos a seguir para generar el certificado son los siguientes:

Genere su :term:`clave privada` ejecutando desde la línea de comandos::

  openssl genrsa -out privada 1024

Reemplazando *privada* por el nombre de archivo de la :term:`clave privada` a generar.
Haga un backup de su :term:`clave privada` para evitar futuros inconvenientes. Tenga
en cuenta que la va a necesitar una vez que obtenga su certificado X.509, el
cual no le va a servir de mucho si Ud. no dispone de la :term:`clave privada` que le
corresponde.

Genere su :term:`CSR` (:term:`Certificate Signing Request`) ejecutando desde la línea de comandos::

  openssl req -new -key privada -subj "/C=AR/O=[empresa]/CN=[nombre]/serialNumber=CUIT [nro_cuit]" -out pedido
  
Reemplazando:

  * *privada* por el nombre de archivo de la clave privada generada en el paso anterior.
  * [empresa] por el nombre de su empresa.
  * [nombre] por su nombre o server hostname.
  * [nro_cuit] por la CUIT sin guiones del contribuyente.

Una vez que haya generado correctamente su :term:`CSR`, puede usarlo para obtener su :term:`certificado digital X.509`.
Para el caso del entorno de :term:`Testing`, envíelo por email a webservices@afip.gov.ar aclarando a qué web service
pretende acceder usando este certificado (ej: :term:`WSFE`, :term:`WSFEX`, etc.). El certificado le será enviado por email.
Para el caso del entorno de :term:`Producción`, Ud. podrá obtener su certificado interactivamente usando la opción
*Adminitración de Certificados Digitales* del menú de trámites con Clave Fiscal en el sitio web de la |AFIP|: http://www.afip.gov.ar.
