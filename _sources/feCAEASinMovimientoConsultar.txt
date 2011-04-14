.. index:: FECAEASinMovimientoConsultar

FECAEASinMovimientoConsultar
============================

Permite consultar cuáles fueron los puntos de venta que fueron notificados como sin movimiento para un determinado CAEA.

Modo de uso
-----------

::

  wsfe FECAEASinMovimientoConsultar <CAEA> <opciones>

donde:

==================== ==================================================
Campo                Descripción
==================== ==================================================
CAEA                 Código de autorización CAEA
==================== ==================================================

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" por cada punto de venta informado como sin movimientos para el CAEA indicado.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
CAEA                 S(14)   CAEA informado
PtoVenta             N(4)    Punto de venta vinculado al CAEA informado
FchProceso           S(8)    Fecha de procesamiento del CAEA (AAAAMMDD)
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfe_common_errors.inc

Errores específicos de este servicio
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

====== ================================================================================
Código Descripción
====== ================================================================================
10100  Código de autorización no válido
10102  Código de autorización no registrado
====== ================================================================================
