#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class Wsfe < Base
      def run(argv)
        args = argv.dup
        load_options(argv)
        servicio = argv.shift 
        case servicio
          when 'FEAutRequest'             then FEAutRequest.run(args)
          when 'FEUltNroRequest'          then FEUltNroRequest.run(args)
          when 'FERecuperaQTYRequest'     then FERecuperaQTYRequest.run(args)
          when 'FERecuperaLastCMPRequest' then FERecuperaLastCMPRequest.run(args)
          when 'FEConsultaCAERequest'     then FEConsultaCAERequest.run(args)
          when 'FEDummy'                  then FEDummy.run(args)
          else                            ;    usage_exit
        end
        WSFE::Client.test
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] <servicio> [argumentos]"
        parser.separator ""
        parse_authentication_options
        parse_other_options
        parse_common_options
      end

      def info_exit
      end      

      def usage_exit
        puts descripcion
        exit 1
      end      
      
      def descripcion
<<__EOD__
Modo de uso: wsfe [opciones] <servicio> [argumentos]

     servicio                        Uno de los servicios provistos por el WSFE de AFIP.
                                     Valores posibles:
                                       - FEDummy
                                       - FEAutRequest
                                       - FEUltNroRequest
                                       - FERecuperaQTYRequest
                                       - FERecuperaLastCMPRequest
                                       - FEConsultaCAERequest
                                       - FEXAuthorize
                                       - FEXCheckPermiso
                                       - FEXDummy
                                       - FEXGetCmp
                                       - FEXGetLastCmp
                                       - FEXGetLastId
                                       - FEXGetParamCtz
                                       - FEXGetParamDstCuit
                                       - FEXGetParamDstPais
                                       - FEXGetParamIncoterms
                                       - FEXGetParamIdiomas
                                       - FEXGetParamMon
                                       - FEXGetParamPtoVenta
                                       - FEXGetParamTipoCbte
                                       - FEXGetParamTipoExpo
                                       - FEXGetParamUMed

                                     La sintaxis de las opciones y argumentos requeridos 
                                     dependen del servicio a utilizar.
                                     Escriba wsfe <servicio> --info para obtener mayor
                                     informacion acerca de un servicio en particular.
__EOD__
      end
    end
  end
end
