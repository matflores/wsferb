.. index:: FEParamGetTiposTributos

FEParamGetTiposTributos
=======================

Devuelve la lista de códigos de tributos habilitados.

Modo de uso
-----------

::

  wsfe FEParamGetTiposTributos <opciones>

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" por cada tipo de tributo habilitado.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
Id                   N(2)    Código
FchDesde             S(8)    Fecha de vigencia desde (AAAAMMDD)
FchHasta             S(8)    Fecha de vigencia hasta (AAAAMMDD)
Desc                 S(250)  Descripción
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfe_common_errors.inc
