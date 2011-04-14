.. index:: FEXGetParamMon

FEXGetParamMon
==============

Devuelve la lista completa de monedas disponibles.

Modo de uso
-----------

::

  wsfe FEXGetParamMon <opciones>

Opciones
~~~~~~~~
.. program:: wsfex

.. option:: -c <cuit>, --cuit <cuit>

   :term:`CUIT` del 

Respuesta
---------

Devuelve una lista de registros con el siguiente formato:

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro
Mon_id               S(3)    Código de moneda
Mon_ds               S(250)  Descripción de moneda
Mon_vig_desde        S(8)    Fecha de vigencia desde (AAAAMMDD)
Mon_vig_hasta        S(8)    Fecha de vigencia hasta (AAAAMMDD)
==================== ======= ==================================================

.. include:: errores.inc
