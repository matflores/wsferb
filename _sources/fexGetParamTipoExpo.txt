.. index:: FEXGetParamTipoExpo

FEXGetParamTipoExpo
===================

Devuelve la lista de tipos de exportación habilitados.

Modo de uso
-----------

::

  wsfex FEXGetParamTipoExpo <opciones>

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" por cada tipo de exportación habilitado.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
Id                   N(3)    Código
FchDesde             S(8)    Fecha de vigencia desde (AAAAMMDD)
FchHasta             S(8)    Fecha de vigencia hasta (AAAAMMDD)
Desc                 S(250)  Descripción
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfex_common_errors.inc
