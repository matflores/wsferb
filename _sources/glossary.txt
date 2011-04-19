.. index:: Glosario

Glosario
========

.. glossary::

   AFIP
       Administración Federal de Ingresos Públicos. Ver sección eFactura_ para más datos sobre los servicios de facturación electrónica.
   CAE
       Código de Autorización Electrónico. Es el código que asigna la |AFIP| al autorizar un comprobante electrónico.
   CAEA
       Código de Autorización Electrónico Anticipado. Utilizado por autoimpresores. En lugar de solicitar un código por comprobante, se solicita un código de autorización por quincena y luego se vinculan los comprobantes emitidos con dicho código de autorización.
   Certificate signing request
       Solicitud que debe ser enviada a una entidad autorizada a fin de recibir un certificado digital. Esta solicitud debe ser firmada digitalmente utilizando criptografía de clave pública. Ver instrucciones para generar un :term:`CSR` en :doc:`certificate_request_howto`.
   Certificado digital
       Un certificado digital es un documento digital que garantiza el vínculo entre una entidad determinada y una clave pública. Para utilizar los web services de facturación electrónica, es necesario solicitar a la |AFIP| un certificado digital X.509 (ver :doc:`certificate_request_howto` para obtener mayor información sobre este proceso).
   Certificado digital X.509
       X.509 es un formato standard para certificados digitales de clave pública. Ver también :term:`Certificado digital`.
   Clave privada
       Una de las dos claves utilizadas en los sistemas de cifrado de clave pública o asimétricos. **WSFErb** requiere una clave privada para firmar las solicitudes de tickets de acceso a los web services de |AFIP|. Una vez generada, debe guardar la clave en un lugar seguro. En :doc:`certificate_request_howto` encontrará instrucciones para generar una clave privada si aún no posee ninguna.
   CSR
       Ver :term:`Certificate signing request`.
   CUIT
       Clave Única de Identificación Tributaria. Siempre que se envía o se recibe un CUIT en **WSFErb** deben incluirse unicamente los 11 dígitos numéricos, sin guiones, espacios, ni otros signos de puntuación.
   Producción
       Entorno real de |AFIP| que debe utilizarse para autorizar legalmente los comprobantes electrónicos emitidos.
   Testing
       Entorno de prueba de |AFIP|. Permite probar la implementación de clientes de los web services y autorizar comprobantes. Los CAEs y CAEAs devueltos en este entorno carecen de validez legal.
   Ticket de acceso
       Todos los web services de |AFIP| requieren que el contribuyente solicite un ticket de acceso para poder utilizarlos. Estos tickets de acceso se solicitan utilizando los servicios :term:`WSAA` y son válidos por 24 horas. **WSFErb** automatiza este proceso por Ud., solicitando un nuevo ticket sólo cuando es necesario (ver opción -t).
   WSAA
       Web Service de Autenticación y Autorización. Ver eFactura_ para más información.
   WSFE
       Web Service de Facturación Electrónica. Ver eFactura_ para más información.
   WSFEv0
       Web Service de Facturación Electrónica versión 0, válido hasta el 30/06/2011. Ver eFactura_ para más información.
   WSFEv1
       Web Service de Facturación Electrónica versión 1, válido desde el 01/03/2011 y obligatorio a partir del 01/07/2011. Ver eFactura_ para más información.
   WSFEX
       Web Service de Facturación Electrónica de Exportación. Ver eFactura_ para más información.
   WSMTXCA
       Web Service de Facturación Electrónica con codificación de productos y detalle de items. Ver eFactura_ para más información.

.. _eFactura: http://www.afip.gov.ar/eFactura
