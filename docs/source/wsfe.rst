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
son necesarias para :doc:`feDummy`):

.. include:: _options.inc


Entornos de ejecución
---------------------

Existen dos entornos distintos para la ejecución de los web services de AFIP: :term:`Testing` y :term:`Producción`.
WSFE utilizará siempre el entorno :term:`Producción`, a menos que le indiquemos lo contrario con la opción --test.

:term:`Testing` se utiliza unicamente en la etapa de pruebas y es el que debemos utilizar durante el desarrollo
hasta confirmar que nuestra aplicación funciona correctamente. Los comprobantes autorizados en este
entorno carecen de validez.

Nomenclatura
------------

Para describir el formato de las respuestas se utiliza la siguiente nomenclatura:

============ =================================== ======= ==================
Tipo de dato Descripción                         Ejemplo Ejemplo formateado
============ =================================== ======= ==================
S(6)         Campo alfanumérico de 6 caracteres  AB123   "AB123 "
N(6)         Campo numérico entero de 6 dígitos  1234    "001234"
N(12,2)      Campo numérico de 12 dígitos        1234.56 "000000123456"
             (10 enteros y 2 decimales)
============ =================================== ======= ==================

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
