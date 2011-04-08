Consideraciones Generales
=========================

Esta sección tiene como objetivo detallar los métodos disponibles en |WSFEX|, el script que facilita el
acceso a los web services de facturación electrónica de exportación, complementando el manual para el
desarrollador provisto por la :term:`AFIP`.

Modo de uso
-----------

::

  wsfe <servicio> [parámetros] [opciones]

Con la excepción de :doc:`fexDummy`, todos los servicios/métodos requieren autorización. La autorización se
obtiene mediante un :term:`ticket de acceso` que se puede solicitar a la |AFIP| utilizando el servicio |WSAA|
(ver documentación WSAA en el sitio web de |AFIP|).

El script |WSFEX| permite automatizar la obtención y verificación de dicho :term:`ticket de acceso`. Para lograrlo se
utilizan las siguientes opciones, válidas para cualquier servicio detallado en este documento (aunque no
son necesarias para FEXDummy):

Opciones
~~~~~~~~

El script |WSFEX| permite automatizar la obtención y verificación de dicho ticket de acceso. Para lograrlo se
utilizan las siguientes opciones, válidas para cualquier servicio detallado en este documento (aunque no
son necesarias para FEXDummy):

.. include:: _options.inc


Entornos de ejecución
---------------------

Existen dos entornos distintos para la ejecución de los web services de AFIP: :term:`Testing` y :term:`Producción`.
WSFEX utilizará siempre el entorno :term:`Producción`, a menos que le indiquemos lo contrario con la opción :option:`-e`.

Servicios
---------

.. toctree::
   :maxdepth: 1

   fexDummy.rst
   fexAuthorize.rst
   fexCheckPermiso.rst
   fexGetCmp.rst
   fexGetLastId.rst
   fexGetLastCmp.rst
   fexGetParamCtz.rst
   fexGetParamDstCuit.rst
   fexGetParamDstPais.rst
   fexGetParamIdiomas.rst
   fexGetParamIncoterms.rst
   fexGetParamMon.rst
   fexGetParamPtoVenta.rst
   fexGetParamTipoCbte.rst
   fexGetParamTipoExpo.rst
   fexGetParamUMed.rst
