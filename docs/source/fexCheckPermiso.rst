.. index:: FEXCheckPermiso

FEXCheckPermiso
===============

Confirma si el permiso de embarque indicado está registrado en la base de datos aduanera y corresponde
al país de destino especificado.

.. note:: En modo :term:`Testing` este servicio devuelve siempre **OK**, sin importar el código de
          permiso de embarque utilizado.

Modo de uso
-----------

::

  wsfex FEXCheckPermiso <permiso> <pais> <opciones>

donde:

==================== ====================================================
Campo                Descripción
==================== ====================================================
Permiso              Código de permiso de embarque
País                 Código de país de destino de la mercadería
==================== ====================================================

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" indicando si el permiso especificado es válido.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
Valor                S(2)    **OK** si el permiso indicado se encuentra
                             registrado en la base de datos aduanera y corresponde
                             al país de destino especificado. **NO** en caso de
                             que no se encuentre ningún permiso de embarque con
                             el código especificado para el país de destino
                             indicado. Valores posibles: **OK** o **NO**.
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfex_common_errors.inc
