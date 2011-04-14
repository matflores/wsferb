.. index:: FEXGetLastId

FEXGetLastId
============

Devuelve el último número de comprobante utilizado para el tipo de comprobante y punto de venta indicados.

Modo de uso
-----------

::

  wsfex FEXGetLastId <opciones>

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" indicando el último número de transacción.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
Id                   N(5)    Ultimo ID utilizado
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfex_common_errors.inc
