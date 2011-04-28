.. index:: FEXGetLastCmp

FEXGetLastCmp
=============

Devuelve el último número de comprobante utilizado para el tipo de comprobante y punto de venta indicados.

Modo de uso
-----------

::

  wsfex FEXGetLastCmp <TipoCbte> <PtoVenta> <opciones>

donde:

==================== ====================================================
Campo                Descripción
==================== ====================================================
TipoCbte             Tipo de comprobante (ver :doc:`fexGetParamTipoCbte`)
PtoVenta             Punto de venta (ver :doc:`fexGetParamPtoVenta`)
==================== ====================================================

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" indicando el último número de comprobante utilizado para el tipo de comprobante y punto de venta especificados.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
NroCbte              N(8)    Número de comprobante
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfex_common_errors.inc
