.. index:: FECAEASinMovimientoInformar

FECAEASinMovimientoInformar
===========================

Permite informar cuáles fueron los CAEA's otorgados que no registraron movimiento alguno para un determinado punto de venta.

Modo de uso
-----------

::

  wsfe FECAEASinMovimientoInformar <CAEA> <PtoVenta> <opciones>

donde:

==================== ==================================================
Campo                Descripción
==================== ==================================================
CAEA                 CAEA sin movimientos
PtoVenta             Punto de Venta en el que no se registraron
                     movimientos para el CAEA informado
==================== ==================================================

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" con el resultado de la operación.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
CAEA                 S(14)   CAEA informado
PtoVenta             N(4)    Punto de venta vinculado al CAEA informado
Resultado            S(1)    Resultado de la operación
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
1200   El código de autorización informado no es de tipo CAEA
1201   El código de autorización informado no correponde al CUIT especificado
1202   El código de autorización informado ya fue utilizado en algún comprobante
1203   El código de autorización informado aún no ha entrado en vigencia
1204   El punto de venta informado no está habilitado para utilizar CAEA
1205   El punto de venta no estuvo activo durante la vigencia del CAEA
====== ================================================================================
