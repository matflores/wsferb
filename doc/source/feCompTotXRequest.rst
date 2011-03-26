.. index:: FECompTotXRequest

FECompTotXRequest
=================

Devuelve la cantidad máxima de registros que se podrá incluir en un request
a los métodos FECAESolicitar y FECAEARegInformativo.

Modo de uso
-----------

::

  wsfe FECompTotXRequest <opciones>

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" indicando la cantidad máxima de registros a incluir en cada lote.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
RegXReq              N(4)    Cantidad de registros
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

====== ================================================================================
Código Descripción
====== ================================================================================
600    Usuario no autorizado a realizar esta operación
601    CUIT solicitante no se encuentra entre sus representados
====== ================================================================================
