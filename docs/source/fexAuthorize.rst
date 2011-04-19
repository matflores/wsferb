.. index:: FEXAuthorize

FEXAuthorize
============

Solicita la autorización de un comprobante de exportación.

Recibe un archivo de texto con los datos del comprobante a autorizar, lo procesa, y genera un archivo de salida
con los mismos datos, más el :term:`CAE` otorgado y algunos datos adicionales.

En el diseño de este método en el |WSFEX| de la |AFIP| se ha previsto que pueden ocurrir interrupciones en la
comunicación entre el cliente y el web service. Basicamente, el cliente envía una solicitud de
autorización al |WSFEX| y se queda esperando una respuesta que no llega, hasta que transcurrido algún
tiempo, se produce una condición de time-out.

En este caso, el usuario no podría determinar si la solicitud le llegó al |WSFEX|, este asignó el
:term:`CAE` y la falla se produjo durante el retorno de la información, o bien si la falla ocurrió
durante el envío de la solicitud y por lo tanto el |WSFEX| nunca la recibió.

En el segundo caso, con simplemente enviar una nueva solicitud todo queda resuelto, pero en el primer
caso, si el cliente envía una nueva solicitud (con un nuevo identificador) para el mismo comprobante, el
|WSFEX| devolvería un error de consecutividad puesto que en la base de datos de |AFIP| ese comprobante
figura como emitido.

Aquí es donde se hace evidente la funcionalidad del campo ID. |WSFEX| archiva en su base de datos todas
las respuestas que devuelve junto con su ID de requerimiento. Cuando recibe una nueva solicitud, lo
primero que hace es verificar en la base de datos si ya tiene archivada una respuesta con ese mismo ID.
En caso afirmativo, aún cuando los datos del comprobante sean totalmente distintos, el web service
procede a devolver la misma respuesta que tiene archivada.

De esta descripción surgen algunas conclusiones importantes:

* Es fundamental asegurarse de no repetir accidentalmente el ID de requerimiento.
* Debe archivarse el ID de cada solicitud puesto que va a ser el único modo de recuperar la información en caso de error.
* Cuando se corrija un error de datos que motivó un rechazo anterior, debe enviarse un ID nuevo. De lo contrario se volverá a obtener el mismo error.

Modo de uso
-----------

::

  wsfex FEXAuthorize <cbte> <opciones>

donde:

==================== ====================================================
Campo                Descripción
==================== ====================================================
Cbte                 Ubicación del archivo de texto que contiene los datos
                     del comprobante a autorizar. Para evitar inconvenientes
                     se recomienda utilizar la ubicación completa del 
                     archivo, y usar nombres cortos utilizando sólo A-Z,
                     0-9 y guiones.
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
