.. index:: WSAA

WSAA
====

Todos los web services de |AFIP| requieren que el usuario obtenga un :term:`ticket de acceso` antes de utilizarlos.
Estos tickets de acceso se obtienen mediante los servicios :term:`WSAA` provistos por |AFIP| y son válidos
por 24 horas.

Los pasos a seguir para solicitar un ticket de acceso son los siguientes:

* Generar el documento del TRA (LoginTicketRequest.xml)
* Generar un CMS que contenga el TRA, su firma electrónica y el :term:`certificado digital X.509` (LoginTicketRequest.xml.cms)
* Codificar en Base64 el CMS (LoginTicketRequest.xml.cms.base64)
* Invocar el método correspondiente del :term:`WSAA` y recibir LoginTicketResponse.xml
* Extraer y validar la información de autorización (el :term:`ticket de acceso` propiamente dicho)

**WSFErb** automatiza el proceso de solicitar un nuevo ticket de acceso cuando es necesario, liberando
al desarrollador de la tarea de implementar todos los pasos detallados en esta sección.
