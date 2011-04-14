.. index:: FECAEARegInformativo

FECAEARegInformativo
====================

Permite informar los comprobantes emitidos asociados a un CAEA previamente otorgado.

Para cada comprobante del lote, pueden producirse las siguientes situaciones:

* Se superan todas las validaciones correctamente, el comprobante es aprobado.
* No se supera alguna de las validaciones no excluyentes, el comprobante es aprobado con observaciones.
* No se supera alguna de las validaciones excluyentes, el comprobante no es aprobado y la solicitud es rechazada.

De acuerdo a las situaciones detalladas, un lote de comprobantes puede ser aprobado, rechazado totalmente o rechazado parcialmente.

Por ejemplo, suponiendo que se envían 100 comprobantes en el mismo lote, las facturas A-0001-00000051 a la A-0001-00000150, hay tres escenarios posibles:

* Aprobación total - cada uno de los 100 comprobantes fue aprobado correctamente.
* Rechazo total - se puede dar por dos causas: por problemas del emisor, o porque el primer comprobante del lote fue rechazado. En el primer caso la respuesta incluirá un registro de tipo "E" por cada error ocurrido. En el segundo, se incluirá un registro de tipo "O" por cada observación realizada al comprobante rechazado.
* Rechazo parcial - se da cuando alguno de los comprobantes es rechazado. En el ejemplo, si se rechaza el comprobante A-0001-00000101, los comprobantes del 51 al 100 serán aprobados, el 101 rechazado, y del 102 al 150 se informarán como no procesados. En este caso se deberán corregir los problemas del comprobante 101 y enviar una nueva solicitud.

Modo de uso
-----------

::

  wsfe FECAEARegInformativo <Lote> <opciones>

donde:

==================== ====================================================
Campo                Descripción
==================== ====================================================
Lote                 Ubicación del archivo de texto que contiene el lote
                     de comprobantes a informar. Para evitar inconvenientes
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
701    CAEA no informado
702    CAEA no corresponde al CUIT informado
703    CAEA ya fue informado como "sin movimientos"
704    CAEA no está vigente
705    Fecha de comprobante no informada
706    Fecha de comprobante no corresponde al período de vigencia de CAEA informado
707    Tipo de comprobante no válido
708    Punto de venta no válido o no habilitado para operar con CAEA
709    Número de comprobante no informado
710    Número de comprobante debe ser el siguiente al último número de comprobante
       informado para este mismo tipo de comprobante y punto de venta
711    Número de comprobante debe ser igual a 1
712    Fecha de comprobante debe ser igual o posterior a la fecha del último
       comprobante informado para este mismo tipo de comprobante y punto de venta
713    Punto de venta no habilitado para operar durante el período de vigencia del
       CAEA informado
715    ImpTrib debe ser mayor o igual a 0
716    ImpTotal debe ser mayor o igual a 0
717    ImpTotConc debe ser mayor o igual a 0
718    ImpOpEx debe ser mayor o igual a 0
719    ImpNeto debe ser mayor o igual a 0
720    Código de moneda no válido o no informado
721    Cotización de moneda no válida o no informada
722    Concepto no válido. Valores posibles:
       01 - Productos,
       02 - Servicios,
       03 - Productos y Servicios
723    Para comprobantes de tipo 02 y 03 sólo pueden asociarse comprobantes de tipo
       01, 02 y 03. Para comprobantes de tipo 07 y 08 pueden asociarse comprobantes
       de tipo 06, 07 y 08.
724    Tributo no informado
727    Tipo/Nro de documento no válidos o no registrados en los padrones de la AFIP
728    Fecha de comprobante debe estar dentro de los 5 días posteriores a la fecha
       actual si Concepto es 01, o entre los 10 días anteriores y 10 posteriores a la
       fecha actual si Concepto es 02 o 03. En cualquier caso deberá ser igual o
       posterior a la del último comprobante emitido para el mismo tipo y punto de
       venta.
730    ImpTrib no coincide con la suma de los importes de tributos informados
731    ImpTotal debe ser igual a ImpTotConc + ImpNeto + ImpOpEx + ImpTrib + ImpIVA
736    Cotización de moneda no válida
737    Fecha desde del servicio a facturar sólo debe informarse para conceptos 02 y 03
738    Fecha hasta del servicio a facturar sólo debe informarse para conceptos 02 y 03
739    Fecha de vencimiento de pago del servicio a facturar sólo debe informarse
       para conceptos 02 y 03
740    Fecha de vencimiento de pago del servicio a facturar debe ser posterior a
       la fecha del comprobante
800    Tipo de comprobante asociado no válido o no informado
801    Punto de venta del comprobante asociado no informado
802    Número de comprobante asociado no informado
803    Comprobante asociado no registrado en AFIP
900    Código de tributo no válido o no informado
901    Descripción del tributo no informada
902    El campo BaseImp (Tributo) debe ser mayor o igual a 0
903    El campo Importe (Tributo) debe ser mayor o igual a 0
1000   Código de alícuota de IVA no válido
1001   El campo Importe (IVA) debe ser mayor o igual a 0
====== ================================================================================
