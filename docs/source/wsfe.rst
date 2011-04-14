WSFE
====

Esta sección tiene como objetivo detallar los métodos disponibles en |WSFE|, el script que facilita el
acceso a los web services de facturación electrónica, complementando el manual para el desarrollador
provisto por la :term:`AFIP`.

Modo de uso
-----------

::

  wsfe <servicio> [parámetros] [opciones]

Con la excepción de :doc:`feDummy`, todos los servicios/métodos requieren autorización. La autorización se
obtiene mediante un :term:`ticket de acceso` que se puede solicitar a la |AFIP| utilizando el servicio |WSAA|
(ver documentación WSAA en el sitio web de |AFIP|).

Opciones
~~~~~~~~

El script |WSFE| permite automatizar la obtención y verificación de dicho :term:`ticket de acceso`. Para lograrlo se
utilizan las siguientes opciones, válidas para cualquier servicio detallado en este documento (aunque no
son necesarias para :doc:`feDummy`).

.. include:: _options.inc
.. include:: _environments.inc
.. include:: _naming_conventions.inc

Servicios
---------

.. toctree::
   :maxdepth: 1

   feCAEAConsultar.rst
   feCAEARegInformativo.rst
   feCAEASinMovimientoConsultar.rst
   feCAEASinMovimientoInformar.rst
   feCAEASolicitar.rst
   feCAESolicitar.rst
   feCompConsultar.rst
   feCompTotXRequest.rst
   feCompUltimoAutorizado.rst
   feDummy.rst
   feParamGetCotizacion.rst
   feParamGetPtosVenta.rst
   feParamGetTiposCbte.rst
   feParamGetTiposConcepto.rst
   feParamGetTiposDoc.rst
   feParamGetTiposIva.rst
   feParamGetTiposMonedas.rst
   feParamGetTiposOpcional.rst
   feParamGetTiposTributos.rst
