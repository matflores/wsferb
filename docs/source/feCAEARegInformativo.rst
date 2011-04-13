.. index:: FECAEARegInformativo

FECAEARegInformativo
====================

Permite informar los comprobantes emitidos asociados a un CAEA previamente otorgado.

Para cada comprobante del lote, pueden producirse las siguientes situaciones:

* Se superan todas las validaciones correctamente, el comprobante es aprobado.
* No se supera alguna de las validaciones no excluyentes, el comprobante es aprobado con observaciones.
* No se supera alguna de las validaciones excluyentes, el comprobante no es aprobado y la solicitud es rechazada.

De acuerdo a las situaciones detalladas, un lote de comprobantes puede ser aprobado, rechazado totalmente o rechazado parcialmente.

Por ejemplo, suponiendo que se envían 100 comprobantes en el mismo lote, las facturas A-0001-00000051 a la A-0001-00000150, hay tres escenarios posibles:

* Aprobación total - cada uno de los 100 comprobantes fue aprobado correctamente.
* Rechazo total - se puede dar por dos causas: por problemas del emisor, o porque el primer comprobante del lote fue rechazado. En el primer caso la respuesta incluirá un registro de tipo "E" por cada error ocurrido. En el segundo, se incluirá un registro de tipo "O" por cada observación realizada al comprobante rechazado.
* Rechazo parcial - se da cuando alguno de los comprobantes es rechazado. En el ejemplo, si se rechaza el comprobante A-0001-00000101, los comprobantes del 51 al 100 serán aprobados, el 101 rechazado, y del 102 al 150 se informarán como no procesados. En este caso se deberán corregir los problemas del comprobante 101 y enviar una nueva solicitud.

Modo de uso
-----------

::

  wsfe FECAEARegInformativo <Lote> <opciones>

donde:

==================== ====================================================
Campo                Descripción
==================== ====================================================
Lote                 Ubicación del archivo de texto que contiene el lote
                     de comprobantes a informar. Para evitar inconvenientes
                     se recomienda utilizar la ubicación completa del 
                     archivo, y usar nombres cortos utilizando sólo A-Z,
                     0-9 y guiones.
==================== ====================================================

Opciones
~~~~~~~~

.. include:: _options.inc

Formato del Lote
----------------

.. include:: _wsfe_lote_entrada.inc

Respuesta
---------

.. include:: _response_format.inc

.. include:: _wsfe_lote_salida.inc

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfe_common_errors.inc

====== ================================================================================
Código Descripción
====== ================================================================================
====== ================================================================================
