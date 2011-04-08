Tipo de Registro E (errores)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La respuesta contiene un registro de tipo "E" por cada error detectado. No se incluirán registros de tipo "E" en caso de que la operación finalice exitosamente.

==================== ======= ==================================================
Campo                Tipo    Descripción
==================== ======= ==================================================
TipoReg              S(1)    Tipo de Registro - "E"
ErrCode              N(6)    Código de error
ErrMessage           S(512)  Descripción del error
==================== ======= ==================================================

