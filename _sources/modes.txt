.. index:: Modos de ejecución

Modos de ejecución
==================

Existen dos modos distintos para la ejecución de los web services de AFIP:

* Modo :term:`Testing`
* Modo :term:`Producción`

**WSFErb** utilizará siempre el modo :term:`Producción`, a menos que le indiquemos lo contrario con la opción --test.

:term:`Testing` se utiliza unicamente en la etapa de pruebas y es el que debemos utilizar durante el desarrollo
hasta confirmar que nuestra aplicación funciona correctamente.

.. important:: Los :term:`CAE` y :term:`CAEA` recibidos en modo :term:`Testing` carecen de validez legal.
