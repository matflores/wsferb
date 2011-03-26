Consideraciones Generales
=========================

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

El script |WSFE| permite automatizar la obtención y verificación de dicho :term:`ticket de acceso`. Para lograrlo se
utilizan las siguientes opciones, válidas para cualquier servicio detallado en este documento (aunque no
son necesarias para FEDummy):

Opciones
~~~~~~~~

El script |WSFE| permite automatizar la obtención y verificación de dicho ticket de acceso. Para lograrlo se
utilizan las siguientes opciones, válidas para cualquier servicio detallado en este documento (aunque no
son necesarias para FEDummy):

.. include:: _options.inc


Entornos de ejecución
---------------------

Existen dos entornos distintos para la ejecución de los web services de AFIP: :term:`Testing` y :term:`Producción`.
WSFE utilizará siempre el entorno :term:`Producción`, a menos que le indiquemos lo contrario con la opción :option:`-e`.

Servicios
---------

.. toctree::
   :maxdepth: 1

   feDummy.rst
   feCAESolicitar.rst
   feCAEASolicitar.rst
   feCAEAConsultar.rst
   feCAEARegInformativo.rst
   feCAEASinMovimientoConsultar.rst
   feCAEASinMovimientoInformar.rst
   feParamGetTiposCbte.rst
   feParamGetTiposConcepto.rst
   feParamGetTiposDoc.rst
   feParamGetTiposIva.rst
   feParamGetTiposMonedas.rst
   feParamGetTiposOpcional.rst
   feParamGetTiposTributos.rst
   feParamGetPtosVenta.rst
   feParamGetCotizacion.rst
   feCompConsultar.rst
   feCompUltimoAutorizado.rst
   feCompTotXRequest.rst
