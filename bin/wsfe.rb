#
# wsfe.rb: Web Services Facturación Electrónica AFIP
# Copyright (C) 2008 Matiás Alejandro Flores <mflores@atlanware.com>
#
require 'getoptlong'
$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
require File.dirname(__FILE__) + '/../lib/wsaaClient.rb'
require File.dirname(__FILE__) + '/../lib/wsfeClient.rb'
#require 'wsaaClient'
#require 'wsfeClient'
require File.dirname(__FILE__) + '/../lib/runner.rb'

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
  include WSFE::Runner

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

  def initialize
    WSFE::Client.disable_ssl
    WSAA::Client.disable_ssl
    silence_warnings do
      run
    end
  end

  def run
    #WSFE::Runner::FEDummyRunner.run(ARGV)
    #options = parse_options
    #servicio = ARGV.shift

    #servicio, cuit, opt = parse_opt(GetoptLong.new(*OptSet))
    #if ARGV.length < 1
    #  usage_exit
    #end
    servicio = ARGV[0]
    case servicio
      when 'FEAutRequest'             : FEAutRequest.run(ARGV)
      when 'FEUltNroRequest'          : FEUltNroRequest.run(ARGV)
      when 'FERecuperaQTYRequest'     : FERecuperaQTYRequest.run(ARGV)
      when 'FERecuperaLastCMPRequest' : FERecuperaLastCMPRequest.run(ARGV)
      when 'FEConsultaCAERequest'     : FEConsultaCAERequest.run(ARGV)
      when 'FEDummy'                  : FEDummy.run(ARGV)
      else
        usage_exit
    end
    0
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
