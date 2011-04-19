El comprobante que se envía a la |AFIP| para autorizar los comprobantes tiene el mismo formato que el comprobante
que se recibe como respuesta conteniendo el :term:`CAE` otorgado.

En ambos casos, el primer caracter de cada registro define el tipo de registro y el formato de los caracteres siguientes.

Los registros de tipo "C", "E" y "V" son válidos unicamente en los comprobantes recibidos como respuesta.

Tipo de Registro 1 (cabecera)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El archivo contiene un único registro de tipo "1" con los datos de la cabecera del comprobante.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
TipoCbte             N(3)    Tipo de comprobante (ver :doc:`fexGetParamTipoCbte`)
PtoVenta             N(4)    Punto de venta (ver :doc:`fexGetParamPtoVenta`)
NroCbte              N(8)    Número de comprobante (ver :doc:`fexGetLastCmp`)
ID                   N(15)   Identificador único del requerimiento
FchCbte              S(8)    Fecha de comprobante (AAAAMMDD)
TipoExpo             N(1)    Tipo de exportación (ver :doc:`fexGetParamTipoExpo`)
PermisoExistente     S(1)    Indica si posee permiso de embarque.
                             Valores posibles: **S**, **N**, o NULL (vacío)
Destino              N(3)    Código del país de destino (ver :doc:`fexGetParamDstPais`)
CuitPais             N(11)   CUIT del país de destino (ver :doc:`fexGetParamDstCuit`).
                             Este dato no es obligatorio si se ingresó algún valor
                             en el campo IdImpositivo.
IdImpositivo         S(50)   Clave de identificación tributaria del comprador
                             Este dato no es obligatorio si se ingresó algún valor
                             en el campo CuitPais.
Cliente              S(200)  Apellido y Nombre o Razón Social del comprador
Domicilio            S(300)  Domicilio comercial del comprador
MonId                S(3)    Código de moneda (ver :doc:`fexGetParamMon`)
MonCotiz             N(12,6) Cotización de la moneda (ver :doc:`fexGetParamCtz`)
ImpTotal             N(15,2) Importe total del comprobante
FormaPago            S(50)   Descripción de la forma de pago
Idioma               S(1)    Idioma del comprobante (ver :doc:`fexGetParamIdiomas`)
IncotermId           S(3)    Incoterm (ver :doc:`fexGetParamIncoterms`)
IncotermDesc         S(20)   Descripción del Incoterm (ver :doc:`fexGetParamIncoterms`)
Observaciones        S(1000) Observaciones
ObsComerciales       S(1000) Observaciones comerciales
==================== ======= ==================================================

Tipo de Registro 2 (permisos)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Un comprobante tiene un registro de tipo "2" por cada permiso de embarque asociado.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "2"
TipoCbte             N(3)    Tipo de comprobante (ver :doc:`fexGetParamTipoCbte`)
PtoVenta             N(4)    Punto de venta (ver :doc:`fexGetParamPtoVenta`)
NroCbte              N(8)    Número de comprobante
IdPermiso            S(16)   Código de despacho / permiso de embarque
Destino              N(3)    Código del país de destino (ver :doc:`fexGetParamDstPais`)
==================== ======= ==================================================

Tipo de Registro 3 (comprobantes asociados)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cada comprobante puede contener uno o más registros de tipo "3", uno por cada comprobante asociado.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "3"
TipoCbte             N(3)    Tipo de comprobante (ver :doc:`fexGetParamTipoCbte`)
PtoVenta             N(4)    Punto de venta (ver :doc:`fexGetParamPtoVenta`)
NroCbte              N(8)    Número de comprobante
TipoCbteAsoc         N(3)    Tipo de comprobante (ver :doc:`fexGetParamTipoCbte`)
PtoVentaAsoc         N(4)    Punto de venta (ver :doc:`fexGetParamPtoVenta`)
NroCbteAsoc          N(8)    Número de comprobante asociado
==================== ======= ==================================================

Tipo de Registro 4 (items)
~~~~~~~~~~~~~~~~~~~~~~~~~~

Cada comprobante contiene un registro de tipo "4" por cada item.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "4"
TipoCbte             N(3)    Tipo de comprobante (ver :doc:`fexGetParamTipoCbte`)
PtoVenta             N(4)    Punto de venta (ver :doc:`fexGetParamPtoVenta`)
NroCbte              N(8)    Número de comprobante
Cantidad             N(12,2) Cantidad
UMed                 N(2)    Unidad de medida (ver :doc:`fexGetParamUMed`)
PrecioUni            N(12,3) Precio unitario
TotalItem            N(14,3) Importe total
ProdId               S(30)   Código de producto
ProdDesc             S(4000) Descripción
==================== ======= ==================================================

Tipo de Registro C (CAE)
~~~~~~~~~~~~~~~~~~~~~~~~

Por cada comprobante procesado, se incluye un registro de tipo "C" indicando el resultado del proceso, el CAE asociado y su fecha de vencimiento.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "C"
TipoCbte             N(3)    Tipo de comprobante (ver :doc:`fexGetParamTipoCbte`)
PtoVenta             N(4)    Punto de venta (ver :doc:`fexGetParamPtoVenta`)
NroCbte              N(8)    Número de comprobante
Resultado            S(1)    Resultado de la operación
CAE                  S(14)   Código de autorización electrónico
FchVtoCAE            S(8)    Fecha de vencimiento del CAE (AAAAMMDD).
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc
