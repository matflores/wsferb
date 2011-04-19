.. index:: WSFE

WSFE
====

Esta sección tiene como objetivo detallar los servicios de **WSFErb** que se comunican con los servicios
:term:`WSFEv1` de |AFIP|.

.. important:: Este documento pretende complementar, y no reemplazar, el `manual para el desarrollador`_ provisto por la |AFIP|.

.. _manual para el desarrollador: http://www.afip.gov.ar/eFactura/documentos/manual_desarrollador_COMPG_v1.pdf

Modo de uso
-----------

::

  wsfe <servicio> [parámetros] [opciones]

.. note:: **WSFErb** incluye dos archivos ejecutables para utilizar los servicios **WSFE**: *wsfe.exe* y *wsfew.exe*.
          Ambos comparten la misma sintaxis y opciones, y la única diferencia entre ambos es que *wsfe.exe*
          es una aplicación de consola y *wsfew.exe* es una aplicación Win32. Si piensa ejecutar **WSFErb**
          desde una aplicación Windows, es probable que la mejor opción sea ejecutar *wsfew.exe* con la opción
          -o para guardar la respuesta en un archivo, evitando así abrir ventanas innecesarias.

          En el resto del documento se utilizará *wsfe.exe* para documentar la sintaxis de cada método, recuerde
          que siempre puede utilizar *wsfew.exe* en su lugar si así lo prefiere.

Opciones
~~~~~~~~

.. include:: _options.inc

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

.. note:: Para emitir comprobantes electrónicos con :term:`CAE`, el único servicio realmente necesario es :doc:`feCAESolicitar`.
          Para emitir comprobantes electrónicos con :term:`CAEA`, los únicos servicios realmente necesarios son :doc:`feCAEASolicitar`,
          :doc:`feCAEARegInformativo` y :doc:`feCAEASinMovimientoInformar`. El resto de los servicios permiten realizar consultas y
          obtener las tablas de códigos referenciales de la |AFIP| y, si bien pueden ser útiles en muchos casos, no se utilizan
          al momento de autorizar un comprobante.
