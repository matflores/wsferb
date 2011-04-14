Entornos de ejecución
---------------------

Existen dos entornos distintos para la ejecución de los web services de AFIP: :term:`Testing` y :term:`Producción`.
WSFErb utilizará siempre el entorno :term:`Producción`, a menos que le indiquemos lo contrario con la opción --test.

:term:`Testing` se utiliza unicamente en la etapa de pruebas y es el que debemos utilizar durante el desarrollo
hasta confirmar que nuestra aplicación funciona correctamente. Los comprobantes autorizados en este
entorno carecen de validez.
