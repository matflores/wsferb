.. index:: WSFEX

WSFEX
=====

Esta sección tiene como objetivo detallar los servicios de **WSFErb** que se comunican con los servicios
:term:`WSFEX` de |AFIP|.

.. important:: Este documento pretende complementar, y no reemplazar, el `manual para el desarrollador`_ provisto por la |AFIP|.

.. _manual para el desarrollador: http://www.afip.gov.ar/eFactura/documentos/WSFEX-Manualparaeldesarrollador_V1.pdf

Modo de uso
-----------

::

  wsfex <servicio> [parámetros] [opciones]

.. note:: **WSFErb** incluye dos archivos ejecutables para utilizar los servicios **WSFEX**: *wsfex.exe* y *wsfexw.exe*.
          Ambos comparten la misma sintaxis y opciones, y la única diferencia entre ambos es que *wsfex.exe*
          es una aplicación de consola y *wsfexw.exe* es una aplicación Win32. Si piensa ejecutar **WSFErb**
          desde una aplicación Windows, es probable que la mejor opción sea ejecutar *wsfexw.exe* con la opción
          -o para guardar la respuesta en un archivo, evitando así abrir ventanas innecesarias.

          En el resto del documento se utilizará *wsfex.exe* para documentar la sintaxis de cada método, recuerde
          que siempre puede utilizar *wsfexw.exe* en su lugar si así lo prefiere.

Opciones
~~~~~~~~

.. include:: _options.inc

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

.. note:: Para emitir comprobantes electrónicos de exportación, el único servicio realmente necesario es :doc:`fexAuthorize`.
          El resto de los servicios permiten realizar consultas y obtener las tablas de códigos referenciales de la |AFIP| y,
          si bien pueden ser útiles en muchos casos, no se utilizan al momento de autorizar un comprobante.
