El comprobante que se envía a la |AFIP| para autorizar los comprobantes tiene el mismo formato que el comprobante
que se recibe como respuesta conteniendo el :term:`CAE` otorgado.

En ambos casos, el primer caracter de cada registro define el tipo de registro y el formato de los caracteres siguientes.

Los registros de tipo "C", "O", "E" y "V" son válidos unicamente en los comprobantes recibidos como respuesta.

Tipo de Registro 1 (cabecera)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El archivo contiene un único registro de tipo "1" con los datos de la cabecera del comprobante.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
ID                   N(15)   Identificador único del requerimiento
TipoCbte             N(3)    Tipo de comprobante (ver :doc:`fexGetParamTipoCbte`)
PtoVenta             N(4)    Punto de venta (ver :doc:`fexGetParamPtoVenta`)
NroCbte              N(8)    Número de comprobante (ver :doc:`fexGetLastCmp`)
FchCbte              S(8)    Fecha de comprobante (AAAAMMDD)
Resultado            S(1)    Resultado
==================== ======= ==================================================

Los últimos dos campos (FchProceso y Resultado) sólo se utilizan al recibir información desde la AFIP. En los lotes de entrada estos campos se deben dejar en blanco.

Tipo de Registro 2 (detalle)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Los lotes de entrada contienen un registro de tipo "2" por cada comprobante a autorizar o informar. Los lotes de salida contienen un registro de tipo "2" por cada comprobante procesado.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "2"
NroCbteDesde         N(8)    Número de comprobante desde (00000001-99999999)
NroCbteHasta         N(8)    Número de comprobante hasta (00000001-99999999)
                             Debe ser igual al número de comprobante desde,
                             a menos que se estén informando varios comprobantes
                             de tipo "B" con importes inferiores a $1000.-, en
                             cuyo caso los campos de importes deberán indicar
                             siempre la suma de todos los comprobantes informados
                             en el mismo registro
Concepto             N(2)    Concepto de la factura. Valores posibles:
                             01 - Productos,
                             02 - Servicios,
                             03 - Productos y Servicios
TipoDoc              N(2)    Tipo de documento (ver :doc:`feParamGetTiposDoc`)
NroDoc               N(11)   Número de documento/CUIT (sin guiones)
FchCbte              S(8)    Fecha de comprobante (AAAAMMDD)
ImpTotal             N(15,2) Importe total del comprobante. Debe ser igual a
                             ImpTotConc + ImpNeto + ImpOpEx + ImpIVA + ImpTrib
ImpTotConc           N(15,2) Importe neto no gravado
ImpNeto              N(15,2) Importe neto gravado
ImpOpEx              N(15,2) Importe exento
ImpIVA               N(15,2) Suma de los importes de los registros de tipo "4"
ImpTrib              N(15,2) Suma de los importes de los registros de tipo "5"
FchServDesde         S(8)    Fecha de inicio del abono para el servicio a facturar
                             (AAAAMMDD). Obligatorio para conceptos 02 y 03
FchServHasta         S(8)    Fecha de fin del abono para el servicio a facturar
                             (AAAAMMDD). Obligatorio para conceptos 02 y 03
FchVtoPago           S(8)    Fecha de vencimiento del pago para el servicio a facturar
                             (AAAAMMDD). Obligatorio para conceptos 02 y 03
MonId                S(3)    Código de moneda (ver :doc:`feParamGetTiposMonedas`)
MonCotiz             N(10,6) Cotización de la moneda informada. Para pesos argentinos
                             debe ser 1
CAEA                 S(14)   Código de autorización electrónica anticipada
==================== ======= ==================================================

El último campo (CAEA) sólo será tenido en cuenta al informar comprobantes con el servicio :doc:`feCAEARegInformativo` y será ignorado en el resto de los casos.

Tipo de Registro 3 (comprobantes asociados)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cada comprobante del lote puede contener uno o más registros de tipo "3" por cada comprobante asociado.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "3"
NroCbteDesde         N(8)    Número de comprobante desde (00000001-99999999)
NroCbteHasta         N(8)    Número de comprobante hasta (00000001-99999999)
TipoCbte             N(3)    Tipo de comprobante (ver :doc:`feParamGetTiposCbte`)
PtoVenta             N(4)    Punto de venta (ver :doc:`feParamGetPtosVenta`)
NroCbte              N(8)    Número de comprobante
==================== ======= ==================================================

Tipo de Registro 4 (iva)
~~~~~~~~~~~~~~~~~~~~~~~~

Cada comprobante contiene un registro de tipo "4" por cada alícuota de IVA aplicada.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "4"
NroCbteDesde         N(8)    Número de comprobante desde (00000001-99999999)
NroCbteHasta         N(8)    Número de comprobante hasta (00000001-99999999)
Id                   N(2)    Código de alícuota de IVA (ver :doc:`feParamGetTiposIva`)
BaseImp              N(15,2) Base imponible sobre la que se aplica el impuesto
Importe              N(15,2) Importe del IVA
==================== ======= ==================================================

Tipo de Registro 5 (tributos)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cada comprobante contiene un registro de tipo "5" por cada tributo aplicado.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "5"
NroCbteDesde         N(8)    Número de comprobante desde (00000001-99999999)
NroCbteHasta         N(8)    Número de comprobante hasta (00000001-99999999)
Id                   N(2)    Código de tributo (ver :doc:`feParamGetTiposTributos`)
BaseImp              N(15,2) Base imponible sobre la que se aplica el impuesto
Alícuota             N(5,2)  Alícuota
Importe              N(15,2) Importe del tributo
Desc                 S(80)   Descripción
==================== ======= ==================================================

Tipo de Registro 6 (opcionales)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El registro de tipo "6" está reservado para usos futuros.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "6"
NroCbteDesde         N(8)    Número de comprobante desde (00000001-99999999)
NroCbteHasta         N(8)    Número de comprobante hasta (00000001-99999999)
Id                   N(2)    Código de dato opcional (ver :doc:`feParamGetTiposOpcional`)
Valor                S(100)  Valor
==================== ======= ==================================================

Tipo de Registro C (CAE/CAEA)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Por cada comprobante procesado, se incluye en el lote un registro de tipo "C" indicando el resultado del proceso, el CAE/CAEA asociado y su fecha de vencimiento.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "C"
NroCbteDesde         N(8)    Número de comprobante desde (00000001-99999999)
NroCbteHasta         N(8)    Número de comprobante hasta (00000001-99999999)
Resultado            S(1)    Resultado de la operación
TipoCAE              S(4)    Tipo de código de autorización (CAE/CAEA)
CAE/CAEA             S(14)   Código de autorización
FchVtoCAE            S(8)    Fecha de vencimiento del CAE (AAAAMMDD). No aplica
                             para códigos de autorización de tipo CAEA.
==================== ======= ==================================================

Tipo de Registro O (observaciones)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Un comprobante puede ser aprobado o rechazado con observaciones. En estos casos el lote de salida incluye un registro de tipo "O" por cada observación realizada por la AFIP.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "C"
NroCbteDesde         N(8)    Número de comprobante desde (00000001-99999999)
NroCbteHasta         N(8)    Número de comprobante hasta (00000001-99999999)
ObsCode              N(6)    Código de observación
ObsMessage           S(512)  Descripción de la observación
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc
