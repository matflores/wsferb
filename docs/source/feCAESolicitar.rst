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

.. include:: _wsfe_lote_entrada.inc

Respuesta
---------

.. include:: _response_format.inc

.. include:: _wsfe_lote_salida.inc

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
====== ================================================================================
