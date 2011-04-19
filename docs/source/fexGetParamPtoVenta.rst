.. index:: FEXGetParamPtoVenta

FEXGetParamPtoVenta
===================

Devuelve la lista de puntos de venta habilitados para emitir comprobantes electrónicos de exportación.

.. note:: En modo :term:`Testing` este servicio devuelve una lista vacía. Aún así,
          en este modo es posible utilizar cualquier punto de venta del 0001 al 9999
          para probar la autorización de comprobantes electrónicos de exportación.

Modo de uso
-----------

::

  wsfex FEXGetParamPtoVenta <opciones>

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" por cada punto de venta habilitado.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
Nro                  N(4)    Punto de venta
Bloqueado            S(1)    Indica si el punto de venta está bloqueado. En
                             ese caso se deberá ingresar al ABM de puntos de
                             venta de |AFIP| para regularizar la situación.
                             Valores posibles: S o N.
FchBaja              S(8)    Fecha de baja (AAAAMMDD)
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfex_common_errors.inc
