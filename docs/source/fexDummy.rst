.. index:: FEXDummy

FEXDummy
========

El único propósito de este método es determinar el estado de los servidores de la :term:`AFIP`.

Si tenemos algún problema con cualquiera de los otros métodos, podemos utilizar **FEXDummy** para
verificar si los servidores de la :term:`AFIP` están funcionando correctamente.

Este es el único método que no requiere un :term:`CUIT` válido, ni :term:`certificado digital`, ni :term:`clave privada`, ni siquiera un :term:`ticket de acceso`.

Modo de uso
-----------

::

  wsfex FEXDummy

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

El registro de tipo "1" informa el estado de los servidores de la |AFIP|.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
AppServer            S(2)    Estado del servidor de aplicaciones
DbServer             S(2)    Estado del servidor de base de datos
AuthServer           S(2)    Estado del servidor de autenticación
==================== ======= ==================================================

.. note::
   Si los servidores de |AFIP| están funcionando correctamente, este método devuelve
   un sólo registro: "1OKOKOK".

.. include:: _errors.inc
.. include:: _events.inc
