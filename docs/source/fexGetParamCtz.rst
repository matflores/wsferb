.. index:: FEXGetParamCtz

FEXGetParamCtz
==============

Devuelve la última cotización registrada en la base de datos aduanera para la moneda indicada.
Este valor es orientativo.

Modo de uso
-----------

::

  wsfex FEXGetParamCtz <moneda> <opciones>

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" con la última cotización registrada para la moneda indicada.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
MonId                S(3)    Código de moneda
MonCotiz             N(12,6) Cotización
FchCotiz             S(8)    Fecha de la cotización (AAAAMMDD)
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfex_common_errors.inc
