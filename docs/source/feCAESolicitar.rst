.. index:: FECAESolicitar

FECAESolicitar
==============

Solicita la autorización de un comprobante o lote de comprobantes.

Para cada comprobante del lote, pueden producirse las siguientes situaciones:

* Se superan todas las validaciones correctamente, el comprobante es aprobado, se informa el CAE y su respectiva fecha de vencimiento.
* No se supera alguna de las validaciones no excluyentes, el comprobante es aprobado con observaciones, se informa el CAE y su respectiva fecha de vencimiento.
* No se supera alguna de las validaciones excluyentes, el comprobante no es aprobado y la solicitud es rechazada.

De acuerdo a las situaciones detalladas, un lote de comprobantes puede ser aprobado, rechazado totalmente o rechazado parcialmente.

Por ejemplo, suponiendo que se envían 100 comprobantes en el mismo lote, las facturas A-0001-00000051 a la A-0001-00000150, hay tres escenarios posibles:

* Aprobación total - cada uno de los 100 comprobantes fue aprobado y posee ahora su propio CAE.
* Rechazo total - se puede dar por dos causas: por problemas del emisor, o porque el primer comprobante del lote fue rechazado. En el primer caso la respuesta incluirá un registro de tipo "E" por cada error ocurrido. En el segundo, se incluirá un registro de tipo "O" por cada observación realizada al comprobante rechazado.
* Rechazo parcial - se da cuando alguno de los comprobantes es rechazado. En el ejemplo, si se rechaza el comprobante A-0001-00000101, los comprobantes del 51 al 100 serán aprobados, el 101 rechazado, y del 102 al 150 se informarán como no procesados. En este caso se deberán corregir los problemas del comprobante 101 y enviar una nueva solicitud.

Modo de uso
-----------

::

  wsfe FECAESolicitar <Lote> <opciones>

donde:

==================== ====================================================
Campo                Descripción
==================== ====================================================
Lote                 Ubicación del archivo de texto que contiene el lote
                     de comprobantes a autorizar. Para evitar inconvenientes
                     se recomienda utilizar la ubicación completa del 
                     archivo, y usar nombres cortos utilizando sólo A-Z,
                     0-9 y guiones.
==================== ====================================================

Opciones
~~~~~~~~

.. include:: _options.inc

Formato del Lote
----------------

.. include:: _wsfe_lote.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfe_common_errors.inc

Errores específicos de este servicio
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

====== ================================================================================
Código Descripción
====== ================================================================================
10001  Cantidad de registros de detalle debe ser mayor a 0
10002  Cantidad de registros de detalle informada no coincide con la cantidad de 
       comprobantes en el lote
10003  Cantidad de registros de detalle mayor a lo permitido (ver :doc:`feCompTotXRequest`)
10004  Punto de venta debe estar comprendido entre 0001 y 9998
10005  Punto de venta no habilitado para el régimen RECE
10006  Tipo de comprobante debe estar comprendido entre 001 y 999
10007  Tipo de comprobante no válido
       Comprobantes válidos A: 01, 02, 03, 04, 05, 34, 39, 60, 63.
       Comprobantes válidos B: 06, 07, 08, 09, 10, 35, 40, 61, 64.
10008  NroCbteDesde debe estar comprendido entre 00000001 y 99999999
10009  NroCbteDesde debe ser igual a NroCbteHasta para comprobantes de tipo B con 
       importes mayores a $1000.-
10010  NroCbteHasta debe estar comprendido entre 00000001 y 99999999
10011  NroCbteDesde debe ser mayor o igual a NroCbteHasta para comprobantes de tipo B
       con importes menores a $1000.-
10012  NroCbteDesde debe ser igual a NroCbteHasta para comprobantes de tipo A
10013  Debe informar el CUIT del cliente para comprobantes de tipo A (TipoDoc = 80)
10014  El resultado de la fórmula ImpTotal / (NroCbteHasta - NroCbteDesde + 1) debe ser 
       menor a $1000.- para comprobantes de tipo B informados en el mismo registro
10015  Tipo/Nro de documento no válidos o no registrados en los padrones de la AFIP
10016  Fecha de comprobante debe estar dentro de los 5 días posteriores a la fecha
       actual si Concepto es 01, o entre los 10 días anteriores y 10 posteriores a la
       fecha actual si Concepto es 02 o 03. En cualquier caso deberá ser igual o
       posterior a la del último comprobante emitido para el mismo tipo y punto de
       venta.
10017  CUIT informado no registrado
10018  Alícuota de IVA no informada
10019  Código de alícuota de IVA no válido
10020  El campo BaseImp (IVA) debe ser mayor a 0
10021  El campo Importe (IVA) debe ser mayor o igual a 0
10022  Alícuota de IVA ya informada. Sólo puede informarse una vez por comprobante,
       deberá totalizar por alícuota de ser necesario.
10023  ImpIVA no coincide con la suma de los importes de IVA informados
10024  Tributo no informado
10025  Código de tributo no válido
10026  El campo BaseImp (Tributo) debe ser mayor o igual a 0
10027  El campo Alícuota (Tributo) debe ser mayor o igual a 0
10028  El campo Importe (Tributo) debe ser mayor o igual a 0
10029  ImpTrib no coincide con la suma de los importes de tributos informados
10030  Concepto no válido. Valores posibles:
       01 - Productos,
       02 - Servicios,
       03 - Productos y Servicios
10031  Fecha desde del servicio a facturar no informada
10032  Fecha hasta del servicio a facturar debe ser igual o posterior a la fecha desde
10033  Fecha hasta del servicio a facturar no informada
10034  Fecha hasta del servicio a facturar debe ser igual o posterior a la fecha desde
10035  Fecha de vencimiento para el pago del servicio a facturar no informada
10036  Fecha de vencimiento para el pago del servicio a facturar debe ser posterior a
       la fecha del comprobante
10037  Moneda no válida
10038  Cotización de moneda no informada
10039  Cotización de moneda no válida
10040  Para comprobantes de tipo 02 y 03 sólo pueden asociarse comprobantes de tipo
       01, 02 y 03. Para comprobantes de tipo 07 y 08 pueden asociarse comprobantes
       de tipo 06, 07 y 08.
10041  Comprobante asociado no válido
10042  Descripción de tributo no informada
10043  ImpTotConc no puede ser mayor al importe total de la operación (ImpTotal) ni menor a 0
10044  ImpOpEx no puede ser mayor al importe total de la operación (ImpTotal) ni menor a 0
10045  ImpNeto no puede ser mayor al importe total de la operación (ImpTotal) ni menor a 0
10046  ImpTrib no puede ser mayor al importe total de la operación (ImpTotal) ni menor a 0
10047  ImpIVA no puede ser mayor al importe total de la operación (ImpTotal) ni menor a 0
10048  ImpTotal debe ser igual a ImpTotConc + ImpNeto + ImpOpEx + ImpTrib + ImpIVA
10049  Debe informar fecha del servicio a facturar y fecha de vencimiento del pago
       para el servicio a facturar para conceptos 02 y 03
====== ================================================================================
