FEXGetLastId
============

Este documento tiene como objetivo detallar los métodos disponibles en WSFEX, el script que facilita el
acceso a los web services de facturación electrónica de exportación, complementando el manual para el
desarrollador provisto por AFIP.

Modo de uso::

  wsfe <servicio> [parámetros] [opciones]

Donde <servicio> puede ser uno de los siguientes: FEDummy, FEAutRequest, FEUltNroRequest,
FERecuperaQTYRequest, FERecuperaLastCMPRequest, FEConsultaCAERequest, FEXAuthorize,
FEXCheckPermiso, FEXDummy, FEXGetCmp, FEXGetLastCmp, FEXGetLastId, FEXGetParamCtz,
FEXGetParamDstCuit, FEXGetParamDstPais, FEXGetParamIncoterms, FEXGetParamIdiomas,
FEXGetParamMon, FEXGetParamPtoVenta, FEXGetParamTipoCbte, FEXGetParamTipoExpo,
FEXGetParamUMed.

En este documento sólo se incluyen aquellos servicios correspondientes al WSFEX de
AFIP (todos los que comienzan con FEX).

Con la excepción de FEXDummy, todos los servicios/métodos requieren autorización. La autorización se
obtiene mediante un ticket de acceso que se puede solicitar a la AFIP utilizando el servicio WSAA (ver
documentación WSAA en el sitio web de AFIP).

El script WSFEX permite automatizar la obtención y verificación de dicho ticket de acceso. Para lograrlo se
utilizan las siguientes opciones, válidas para cualquier servicio detallado en este documento (aunque no
son necesarias para FEXDummy):

======= ==== ================
Campo   Tipo Descripción
======= ==== ================
TipoReg S(1) Tipo de Registro
Valor   N(5) Ultimo ID utilizado
======= ==== ================

======= ====== ================
Campo   Tipo   Descripción
======= ====== ================
TipoReg S(1)   Tipo de Registro
Codigo  N(6)   Código de error
Mensaje S(512) Mensaje de error
======= ====== ================
