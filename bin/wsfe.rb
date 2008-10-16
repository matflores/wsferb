#
# wsfe.rb: Web Service Facturación Electrónica AFIP
# Copyright (C) 2008 Matiás Alejandro Flores <mflores@atlanware.com>
#
require 'getoptlong'
require File.dirname(__FILE__) + '/../lib/wsaaClient.rb'
require File.dirname(__FILE__) + '/../lib/wsfeClient.rb'
#require 'wsaaClient'
#require 'wsfeClient'

module Kernel
  def silence_warnings
    old_verbose, $VERBOSE = $VERBOSE, nil
    yield
  ensure
    $VERBOSE = old_verbose
  end
end

class WsfeClientApp

# ver http://www.ruby-doc.org/core/classes/GetoptLong.html
#
  OptSet = [
    ['--cuit'     ,'-c', GetoptLong::REQUIRED_ARGUMENT],
    ['--ticket'   ,'-t', GetoptLong::REQUIRED_ARGUMENT],
    ['--cert'     ,'-r', GetoptLong::REQUIRED_ARGUMENT],
    ['--key'      ,'-k', GetoptLong::REQUIRED_ARGUMENT],
    ['--out'      ,'-o', GetoptLong::REQUIRED_ARGUMENT],
    ['--xml'      ,'-x', GetoptLong::REQUIRED_ARGUMENT],
    ['--servicios','-s', GetoptLong::NO_ARGUMENT],
    ['--info'     ,'-i', GetoptLong::NO_ARGUMENT]
  ]

  Info_aut = <<__EOT__
  --cuit cuit     cuit del contribuyente (requerido)
  --ticket ticket ubicacion del ticket de acceso. Si existe y el ticket
                  aun es valido, se utilizara el ticket de acceso. En 
                  caso contrario, se solicitara un nuevo ticket y se
                  almacenara en la ubicacion especificada.
                  Valor por defecto: ./<cuit>.xml
  --cert cert     ubicacion del certificado digital provisto por AFIP
                  Valor por defecto: ./<cuit>.crt
  --key key       ubicacion de la clave privada que se utilizara para
                  firmar las solicitudes
                  Valor por defecto: ./<cuit>.key
__EOT__
  Info_out = <<__EOT__
  --out, -o archivo guarda la respuesta en el archivo indicado (opcional)
__EOT__
  Info_fEDummy = "\nModo de uso: wsfe [opciones] FEDummy\n\nOpciones:\n#{Info_out}\n"

  def info(servicio, parametros, opciones)
    puts "\nModo de uso: wsfe [opciones] #{servicio}\n\nOpciones:\n" + opciones.join("\n")
  end

  def initialize
    WSFE::Client.disable_ssl
    WSAA::Client.disable_ssl
    silence_warnings do
      run
    end
  end

  def parse_options
    parser = WSFE::OptionParser.new
    parser.order!(ARGV)
    parser.options
  end
  
  def run
    options = parse_options
    #servicio = ARGV.shift

    servicio, cuit, opt = parse_opt(GetoptLong.new(*OptSet))
    if ARGV.length < 1
      usage_exit
    end
    servicio = ARGV.shift
    case servicio
      when 'FEAutRequest'             : WSFE::FEAutRequest.run
      when 'FEUltNroRequest'          : fEUltNroRequest(cuit, opt)
      when 'FERecuperaQTYRequest'     : fERecuperaQTYRequest(cuit, opt)
      when 'FERecuperaLastCMPRequest' : fERecuperaLastCMPRequest(cuit, opt)
      when 'FEConsultaCAERequest'     : fEConsultaCAERequest(cuid, opt)
      when 'FEDummy'                  : fEDummy(opt)
      else
        usage_exit
    end
    0
  end

  def usage_exit
    puts <<__EOU__

Modo de uso: wsfe [opciones] <servicio> [argumentos]

  servicio: uno de los servicios soportados por el WSFE de AFIP.

    Valores posibles:
      - FEDummy
      - FEAutRequest
      - FEUltNroRequest
      - FERecuperaQTYRequest
      - FERecuperaLastCMPRequest
      - FEConsultaCAERequest

Las opciones y argumentos requeridos varian segun el servicio. Escriba wsfe --info <servicio> para obtener mas informacion acerca de un servicio especifico.

__EOU__
    exit 1
  end

  def info_FEDummy
    info("FEDummy","",[Info_aut,Info_out])
#    puts Info_fEDummy
  end

  def info_FEUltNroRequest
    puts <<__EOU__

Modo de uso: wsfe [opciones] FEUltNroRequest 
  -c, --cuit CUIT cuit del contribuyente (requerido)
  -o, --out ARCHIVO guarda la respuesta en el archivo indicado (opcional)
  -t ticket       ubicacion del ticket de acceso. Si existe y el ticket
                  aun es valido, se utilizara el ticket de acceso. En 
                  caso contrario, se solicitara un nuevo ticket y se
                  almacenara en la ubicacion especificada.
                  Valor por defecto: ./<cuit>.xml
  --cert cert     ubicacion del certificado digital provisto por AFIP
                  Valor por defecto: ./<cuit>.crt
  --key key       ubicacion de la clave privada que se utilizara para
                  firmar las solicitudes
                  Valor por defecto: ./<cuit>.key

__EOU__
  end

  def info_FERecuperaQTYRequest
    puts <<__EOU__

Modo de uso: wsfe [opciones] FERecuperaQTYRequest 
  --cuit cuit     cuit del contribuyente (requerido)
  -s archivo      guarda la respuesta en el archivo indicado (opcional)
  -t ticket       ubicacion del ticket de acceso. Si existe y el ticket
                  aun es valido, se utilizara el ticket de acceso. En 
                  caso contrario, se solicitara un nuevo ticket y se
                  almacenara en la ubicacion especificada.
                  Valor por defecto: ./<cuit>.xml
  --cert cert     ubicacion del certificado digital provisto por AFIP
                  Valor por defecto: ./<cuit>.crt
  --key key       ubicacion de la clave privada que se utilizara para
                  firmar las solicitudes
                  Valor por defecto: ./<cuit>.key

__EOU__
  end
 
  def info_FERecuperaLastCMPRequest
    puts <<__EOU__

Modo de uso: wsfe [opciones] FERecuperaLastCMPRequest <tipo-cbte> <punto-vta>
  --cuit cuit     cuit del contribuyente (requerido)
  --ticket ticket ubicacion del ticket de acceso. Si existe y el ticket
                  aun es valido, se utilizara el ticket de acceso. En 
                  caso contrario, se solicitara un nuevo ticket y se
                  almacenara en la ubicacion especificada.
                  Valor por defecto: ./<cuit>.xml
  --cert cert     ubicacion del certificado digital provisto por AFIP
                  Valor por defecto: ./<cuit>.crt
  --key key       ubicacion de la clave privada que se utilizara para
                  firmar las solicitudes
                  Valor por defecto: ./<cuit>.key
  
  <tipo-cbte>     tipo de comprobante (ver tabla AFIP)
  <punto-vta>     punto de venta

__EOU__
  end
 
  def info_FEConsultaCAERequest
    puts <<__EOU__

Modo de uso: wsfe [opciones] FEConsultaCAERequest <cae> <cuit-emisor> <tipo-cbte> <punto-vta> <nro-cbte> <total> <fecha>
  --cuit cuit     cuit del contribuyente (requerido)
  --ticket ticket ubicacion del ticket de acceso. Si existe y el ticket
                  aun es valido, se utilizara el ticket de acceso. En 
                  caso contrario, se solicitara un nuevo ticket y se
                  almacenara en la ubicacion especificada.
                  Valor por defecto: ./<cuit>.xml
  --cert cert     ubicacion del certificado digital provisto por AFIP
                  Valor por defecto: ./<cuit>.crt
  --key key       ubicacion de la clave privada que se utilizara para
                  firmar las solicitudes
                  Valor por defecto: ./<cuit>.key
  --out archivo   guarda la respuesta en el archivo indicado (opcional)
  
  <cae>           CAE a verificar
  <cuit-emisor>   cuit emisor del comprobante
  <tipo-cbte>     tipo de comprobante (ver tabla AFIP)
  <punto-vta>     punto de venta
  <nro-cbte>      nro de comprobante
  <total>         importe total de la operacion o lote
  <fecha>         fecha del comprobante (AAAAMMDD)

__EOU__
  end
 
  def info_FEAutRequest
    puts <<__EOU__

Modo de uso: wsfe [opciones] FEAutRequest <lote> <salida>
  --cuit cuit     cuit del contribuyente (requerido)
  --ticket ticket ubicacion del ticket de acceso. Si existe y el ticket
                  aun es valido, se utilizara el ticket de acceso. En 
                  caso contrario, se solicitara un nuevo ticket y se
                  almacenara en la ubicacion especificada.
                  Valor por defecto: ./<cuit>.xml
  --cert cert     ubicacion del certificado digital provisto por AFIP
                  Valor por defecto: ./<cuit>.crt
  --key key       ubicacion de la clave privada que se utilizara para
                  firmar las solicitudes
                  Valor por defecto: ./<cuit>.key
  --xml xml       guarda el xml devuelto por AFIP en el archivo indicado, 
                  antes de procesarlo (opcional)
  --servicios     indica que lo que se esta facturando corresponde a 
                  prestacion de servicios (opcional)
  
  <lote>          ubicacion del archivo con el lote a facturar 
                  (ver formato RECE AFIP)
  <salida>        ubicacion del archivo en el que se almacenaran los
                  resultados de la operacion (ver formato RECE)

__EOU__
  end

  def parse_opt(getoptlong)
    opt = {}
    servicio = nil
    cuit = nil
    begin
      getoptlong.each do |name, arg|
       	case name
          when "--servicio"
            servicio = arg.strip
          when "--cuit"
            cuit = arg.strip
          when "--esservicios", "--info"
            opt[name.sub(/^--/, '')] = true
   	      when "--cert", "--key", "--ticket", "--id",
               "--input", "--output", "--xml"
            opt[name.sub(/^--/, '')] = arg.empty? ? nil : arg.strip
          else
            raise ArgumentError.new("Opcion no valida: #{ arg }")
        end
      end
    rescue
      usage_exit
    end
    return servicio, cuit, opt
  end

  def fEDummy(opt)
    r = WSFE::Client.test
    if opt['output'] && !opt['output'].empty?
      File.open(opt['output'], 'w') { |f| f.puts(r) }
    else
      puts r
    end
  end

  def fEAutRequest(cuit, opt)
    id = opt['id']
    esServicios = opt['esservicios'] == true
    lote = opt['input']
    salida = opt['output']
    xml_file = opt['xml']
    ticket = obtieneTicket(cuit, opt)
    if !id || !cuit || !lote || !salida
      usage_exit and return
    end
    WSFE::Client.factura_lote(ticket, id, cuit, esServicios, lote, salida, xml_file)
  end

  def fEUltNroRequest(cuit, opt)
    if !opt['output'] || opt['output'].empty? || !cuit || cuit.empty? 
      usage_exit and return
    end
    ticket = obtieneTicket(cuit, opt)
    WSFE::Client.recuperaUltNroTransaccion(ticket).save(opt['output'])
  end

  def fERecuperaQTYRequest(cuit, opt)
    if !opt['output'] || opt['output'].empty? || !cuit || cuit.empty?
      usage_exit and return
    end
    ticket = obtieneTicket(cuit, opt)
    WSFE::Client.recuperaMaxQty(ticket).save(opt['output'])
  end

  def fERecuperaLastCMPRequest(cuit, opt)
    if !opt['output'] || opt['output'].empty? || !cuit || cuit.empty? || !opt['puntovta'] || opt['puntovta'].empty? || !opt['tipocbte'] || opt['tipocbte'].empty?
      usage_exit and return
    end
    ticket = obtieneTicket(cuit, opt)
    WSFE::Client.recuperaUltNroCbte(ticket).save(opt['output'])
  end

  def fEConsultaCAERequest(cuit, opt)
    if !opt['output'] || opt['output'].empty? || !cuit || cuit.empty? || !opt['puntovta'] || opt['puntovta'].empty? || !opt['tipocbte'] || opt['tipocbte'].empty? || !opt['cuitemisor'] || opt['cuitemisor'].empty? || !opt['nrocbte'] || opt['nrocbte'].empty? || !opt['total'] || opt['total'].empty? || !opt['cae'] || opt['cae'].empty? || !opt['fecha'] || opt['fecha'].empty?
      usage_exit and return
    end
    cae = opt['cae']
    cuitEmisor = opt['cuitemisor']
    puntoVta = opt['puntovta']
    tipoCbte = opt['tipocbte']
    nroCbte = opt['nrocbte']
    total = opt['total']
    fecha = opt['fecha']
    ticket = obtieneTicket(cuit, opt)
    WSFE::Client.verificaCAE(ticket, cae, cuitEmisor, puntoVta, tipoCbte, nroCbte, total, fecha)
  end

  def obtieneTicket(cuit, opt)
    cert_file = opt['cert'] || "./#{cuit}.crt"
    key_file = opt['key'] || "./#{cuit}.key"
    ticket = WSAA::Ticket.load(cuit, opt['ticket']) if opt['ticket']
    ticket = WSAA::Client.requestTicket(cuit, 'wsfe', cert_file, key_file) if ticket.nil? || ticket.invalid?
    ticket.save(opt['ticket']) if ticket && ticket.valid? && opt['ticket']
    ticket
  end
end

WsfeClientApp.new
