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
son necesarias para :doc:`fexDummy`):

.. include:: _options.inc


Entornos de ejecución
---------------------

Existen dos entornos distintos para la ejecución de los web services de AFIP: :term:`Testing` y :term:`Producción`.
WSFEX utilizará siempre el entorno :term:`Producción`, a menos que le indiquemos lo contrario con la opción --test.

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
