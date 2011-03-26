.. option:: -c <cuit>, --cuit <cuit>

   :term:`CUIT` del contribuyente. Sólo los 11 dígitos numéricos, sin guiones ni signos de puntuación. Esta
   es la única opción obligatoria para todos los servicios.

.. option:: -r <cert-file>, --cert <cert-file>

   Ubicación del :term:`certificado digital` provisto por la |AFIP|. En caso de no estar presente se intentará
   localizar el :term:`certificado digital` "<cuit>.crt" en el directorio actual. De no existir dicho archivo,
   no se podrá solicitar un nuevo :term:`ticket de acceso` en caso de necesitarlo.

.. option:: -k <key-file>, --key <key-file>

   Ubicación de la :term:`clave privada` utilizada para firmar el :term:`CSR` enviado a la |AFIP|.
   En caso de no estar presente se intentará localizar la :term:`clave privada` "<cuit>.key" en el directorio
   actual. De no existir dicho archivo, no se podrá solicitar un nuevo :term:`ticket de acceso` en caso de
   necesitarlo.

.. option:: -t <ticket-file>, --ticket <ticket-file>

   Ubicación de un :term:`ticket de acceso` provisto por la |AFIP| con anterioridad. Si el archivo existe y
   el ticket aún es válido, se utilizará este :term:`ticket de acceso` en lugar de solicitar uno nuevo. Si
   en cambio el archivo no existe, o si existe pero el ticket ya expiró, se solicitará un nuevo
   :term:`ticket de acceso`. En todos los casos en que sea necesario solicitar un nuevo :term:`ticket de acceso`,
   el mismo será almacenado en el <ticket-file> especificado. En caso de no estar presente esta opción, se
   intentará localizar el :term:`ticket de acceso` "<cuit>.xml" en el directorio actual. De no existir dicho
   archivo, se requerirá un nuevo :term:`ticket de acceso` al |WSAA| de la |AFIP| por cada transacción. Por
   este motivo se recomienda utilizar esta opción siempre que sea posible.

.. option:: -o <path>, --out <path>

   Guarda la respuesta en el archivo indicado en lugar de mostrarla por pantalla.

.. option:: -l <path>, --log <path>

   Guarda un log de la comunicación con los web services de AFIP en el archivo indicado.

.. option:: -e, --test

   Ejecuta el servicio en el entorno de pruebas (:term:`Testing`).

.. option:: -i, --info

   Muestra más información sobre la sintaxis del servicio especificado.

.. option:: -v, --version

   Informa la versión actual del script.
