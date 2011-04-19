.. index:: FEXGetCmp

FEXGetCmp
=========

Permite consultar los datos de un comprobante ya emitido.

Modo de uso
-----------

::

  wsfex FEXGetCmp <TipoCbte> <PtoVenta> <NroCbte> <opciones>

donde:

==================== ====================================================
Campo                Descripción
==================== ====================================================
TipoCbte             Tipo de comprobante (ver :doc:`fexGetParamTipoCbte`)
PtoVenta             Punto de venta (ver :doc:`fexGetParamPtoVenta`)
NroCbte              Número de comprobante
==================== ====================================================

Opciones
~~~~~~~~

.. include:: _options.inc

Formato del Archivo
-------------------

.. include:: _wsfex_cbte.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfex_common_errors.inc

Errores específicos de este servicio
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Consulte el el `manual para el desarrollador`_ provisto por la |AFIP|.

.. _manual para el desarrollador: http://www.afip.gov.ar/eFactura/documentos/WSFEX-Manualparaeldesarrollador_V1.pdf
