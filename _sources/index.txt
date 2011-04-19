.. WSFErb documentation master file, created by
   sphinx-quickstart on Fri Mar 18 17:40:13 2011.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

WSFErb
======

Introducción
------------

**WSFErb** es un utilitario desarrollado en Ruby_ con el objetivo de facilitar la comunicación con los web services de facturación electrónica
provistos por la |AFIP|.

Para obtener más información sobre estos web services, visite la sección `Factura Electrónica`_ en el sitio de la |AFIP|.

.. _Ruby: http://ruby-lang.org
.. _Factura Electrónica: http://www.afip.gov.ar/eFactura

Características
---------------

* Multiplataforma (Windows, GNU/Linux, Mac OS)
* Soporta todos los métodos de los web services :doc:`wsaa`, :doc:`wsfe` (v1) y :doc:`wsfex`
* Automatiza la solicitud de tickets de acceso requerida por |AFIP|, haciendo que la autenticación sea transparente para el usuario
* Permite trabajar en modo prueba y modo producción
* Permite guardar un log de la comunicación con |AFIP| (XML, información enviada/recibida, mensajes de error, etc.)
* No requiere conocimientos previos sobre web services, SOAP, XML, criptografía, etc.

Alcance
-------

**WSFErb** se limita a simplificar la comunicación con los web services de |AFIP|. Los trámites legales y/o fiscales, 
la impresión y el almacenamiento electrónico de los comprobantes autorizados, como así también cualquier otra
tarea adicional requerida por las resoluciones generales de la |AFIP| están fuera del alcance de este software.

Requisitos
----------

Windows
~~~~~~~

* **WSFE**: wsfe.exe y/o wsfew.exe
* **WSFEX**: wsfex.exe y/o wsfexw.exe

GNU/Linux y Mac OS
~~~~~~~~~~~~~~~~~~

* **WSFErb** source files
* Ruby 1.8.7 o superior

Todas las plataformas
~~~~~~~~~~~~~~~~~~~~~

* :term:`Certificado Digital X.509` otorgado por la |AFIP| (ver :doc:`certificate_request_howto`)
* :term:`Clave privada` utilizada para generar el :term:`CSR` (ver :doc:`certificate_request_howto`)

¿Cómo empezar?
--------------

El primer paso es definir qué web service de |AFIP| debe utilizar. Esto determinará el archivo ejecutable o script a utilizar para facturar.

* :doc:`wsfe` - para autorizar comprobantes de tipo **A** y **B** sin detalle de items. Utilice wsfe.exe o wsfew.exe.
* :doc:`wsfex` - para autorizar comprobantes de tipo **E** (sólo exportadores). Utilice wsfex.exe o wsfexw.exe.
* :doc:`wsmtxca` - para autorizar comprobantes de tipo **A** y **B** con detalle de items. Actualmente este servicio no está soportado por **WSFErb**.

.. important:: A partir de la v2.0, **WSFErb** utiliza el web service :term:`WSFEv1` de la |AFIP| para autorizar comprobantes **A** y **B**.
               Las versiones anteriores utilizaban :term:`WSFEv0`, que será discontinuado por la |AFIP| a partir de julio de 2011.

El paso siguiente es determinar en qué modo o entorno vamos a trabajar. Se recomienda trabajar en el entorno :term:`Testing` durante
la implementación, hasta confirmar que todo está funcionando como corresponde. Para mayor información, ver :doc:`modes`.

Luego debemos generar una :term:`clave privada` y solicitar un :term:`certificado digital X.509` a la |AFIP|.
En la sección :doc:`certificate_request_howto` se explican paso a paso las instrucciones para generar la clave y
obtener dicho certificado.

Se recomienda crear una copia de respaldo del certificado y la clave privada para evitar inconvenientes.

Copiar el exe a utilizar, el certificado digital provisto por |AFIP| y la clave privada generada en el equipo que se utilizará
para autorizar los comprobantes electrónicos.

Llegado este punto ya estamos en condiciones de comenzar a solicitar la autorización de comprobantes electrónicos.
Consultar la documentación de cada servicio para más datos.

.. include:: _naming_conventions.inc

Servicios
---------

.. toctree::
   :maxdepth: 3

   wsaa.rst
   wsfe.rst
   wsfex.rst
   wsmtxca.rst

¿Cómo obtener WSFErb?
---------------------

Actualmente **WSFErb** forma parte de otros productos comerciales y no se comercializa por separado.
Consulte `Factur-e`_ si está buscando una solución comercial basada en **WSFErb**.

.. _Factur-e: http://www.evolutionconsulting.com.ar/evolution-factur-e.html

Soporte técnico
---------------

Contáctese via email a wsferb@atlanware.com o info@evolutionconsulting.com.ar.

Información adicional
---------------------

.. toctree::
   :maxdepth: 1

   modes.rst
   certificate_request_howto.rst
   glossary.rst
   changelog.rst
