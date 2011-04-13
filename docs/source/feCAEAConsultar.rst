.. index:: FECAEAConsultar

FECAEAConsultar
===============

Permite consultar la información correspondiente a un CAEA previamente otorgado.

Modo de uso
-----------

::

  wsfe FECAEAConsultar <Período> <Quincena> <opciones>

donde:

==================== ====================================================
Campo                Descripción
==================== ====================================================
Período              Período del CAEA (AAAAMM)
Quincena             Quincena (valores posibles: "1" y "2")
==================== ====================================================

Opciones
~~~~~~~~

.. include:: _options.inc

Respuesta
---------

.. include:: _response_format.inc

Tipo de Registro 1
~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "1" con el CAEA otorgado y la vigencia del mismo.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "1"
Período              N(6)    Período asociado al CAEA (AAAAMM)
Quincena             N(1)    Quincena asociada al CAEA
CAEA                 S(14)   CAEA otorgado
FchVigDesde          S(8)    Fecha de vigencia del CAEA (AAAAMMDD)
FchVigHasta          S(8)    Fecha de vigencia del CAEA (AAAAMMDD)
FchTopeInf           S(8)    Fecha tope para informar comprobantes vinculados a
                             este CAEA (AAAAMMDD)
FchProceso           S(8)    Fecha de procesamiento del CAEA (AAAAMMDD)
==================== ======= ==================================================

.. include:: _errors.inc
.. include:: _events.inc

Errores Posibles
~~~~~~~~~~~~~~~~

Este servicio puede devolver los siguientes códigos de error:

.. include:: _wsfe_common_errors.inc

Errores específicos de este servicio
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

====== ================================================================================
Código Descripción
====== ================================================================================
15000  CUIT no autorizado a solicitar CAEA
15001  CUIT no registrado como autoimpresor
15002  CUIT con comprobantes apócrifos
15003  CUIT sin puntos de venta bajo el régimen CAEA
15004  Período no válido
15005  Quincena no válida
15006  Fecha de envío no válida. Debe estar dentro de los 5 (cinco) días corridos
       anteriores al inicio de la quincena.
15007  Período/Quincena no válidos
15008  Ya existe un CAEA otorgado para el mismo CUIT, período y quincena.
====== ================================================================================
