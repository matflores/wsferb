WSFEX
=====

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

Opciones
~~~~~~~~

El script |WSFEX| permite automatizar la obtención y verificación de dicho :term:`ticket de acceso`. Para lograrlo se
utilizan las siguientes opciones, válidas para cualquier servicio detallado en este documento (aunque no
son necesarias para :doc:`fexDummy`).

.. include:: _options.inc
.. include:: _environments.inc
.. include:: _naming_conventions.inc

Servicios
---------

.. toctree::
   :maxdepth: 1

   fexAuthorize.rst
   fexCheckPermiso.rst
   fexDummy.rst
   fexGetCmp.rst
   fexGetLastCmp.rst
   fexGetLastId.rst
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
