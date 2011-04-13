.. index:: FECompConsultar

FECompConsultar
===============

Permite consultar los datos de un comprobante ya emitido.

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

Respuesta
---------

.. include:: _response_format.inc
.. include:: _cbte_wsfe.inc

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

====== ================================================================================
Código Descripción
====== ================================================================================
600    Usuario no autorizado a realizar esta operación
601    CUIT solicitante no se encuentra entre sus representados
10104  Punto de venta no registrado
10200  Punto de venta no válido
10201  Tipo de comprobante no válido
====== ================================================================================
