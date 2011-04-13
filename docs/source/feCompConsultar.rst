.. index:: FECompConsultar

FECompConsultar
===============

Permite consultar los datos de un comprobante ya emitido. Devuelve un lote con un sólo registro de tipo "2".

Modo de uso
-----------

::

  wsfe FECompConsultar <TipoCbte> <PtoVenta> <NroCbte> <opciones>

donde:

==================== ====================================================
Campo                Descripción
==================== ====================================================
TipoCbte             Tipo de comprobante (ver :doc:`feParamGetTiposCbte`)
PtoVenta             Punto de venta (ver :doc:`feParamGetPtosVenta`)
NroCbte              Número de comprobante
==================== ====================================================

Opciones
~~~~~~~~

.. include:: _options.inc

Formato del Lote
----------------

.. include:: _wsfe_lote.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfe_common_errors.inc

Errores específicos de este servicio
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

====== ================================================================================
Código Descripción
====== ================================================================================
10104  Punto de venta no registrado
10200  Punto de venta no válido
10201  Tipo de comprobante no válido
====== ================================================================================
