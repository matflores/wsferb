.. index:: FEXDummy

FEXDummy
========

El único propósito de este método es determinar el estado de los servidores de la :term:`AFIP`.

Si tenemos algún problema con cualquiera de los otros métodos, podemos utilizar FEXDummy para
verificar si los servidores de la :term:`AFIP` están funcionando correctamente.

Este es el único método que no requiere un :term:`CUIT` válido, ni :term:certificados, ni :term:claves, ni un :term:`ticket de acceso`.

Modo de uso
-----------

::

  wsfe FEXDummy

Opciones
~~~~~~~~
.. program:: wsfex

.. option:: -m <module>, --module <module>

   Run a module as a script.

Respuesta (exitosa)::
-------------------

Respuesta exitosa::

  authserver=OK; appserver=OK; dbserver=OK;

.. note::
   Note that if you use the :option:`-m` option, a module will be included. See :term:`service`.

.. warning::
   A warning note. See :term:`service`.

.. seealso::
  :doc:`fexGetLastId`
    Get last id used
