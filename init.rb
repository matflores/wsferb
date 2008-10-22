#
# Web Services Facturación Electrónica AFIP
# Copyright (C) 2008 Matiás Alejandro Flores <mflores@atlanware.com>
#
$: << File.expand_path(File.dirname(__FILE__) + "/lib")

require 'wsfe'

module Kernel
  def silence_warnings
    old_verbose, $VERBOSE = $VERBOSE, nil
    yield
  ensure
    $VERBOSE = old_verbose
  end
end

class WsfeClientApp

  include WSFE::Runner

  def initialize
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
end

WsfeClientApp.new
