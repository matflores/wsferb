#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class Wsfex < Base
      def run(argv)
        args = argv.dup
        load_options(argv)
        servicio = argv.shift 
        case servicio
          when 'FEXDummy'                  : FEXDummy.run(args)
          when 'FEXGetLastCmp'             : FEXGetLastCmp.run(args)
          when 'FEXGetLastId'              : FEXGetLastId.run(args)
          when 'FEXGetParamCtz'            : FEXGetParamCtz.run(args)
          when 'FEXGetParamDstCuit'        : FEXGetParamDstCuit.run(args)
          when 'FEXGetParamDstPais'        : FEXGetParamDstPais.run(args)
          when 'FEXGetParamIncoterms'      : FEXGetParamIncoterms.run(args)
          when 'FEXGetParamIdiomas'        : FEXGetParamIdiomas.run(args)
          when 'FEXGetParamMon'            : FEXGetParamMon.run(args)
          when 'FEXGetParamPtoVenta'       : FEXGetParamPtoVenta.run(args)
          when 'FEXGetParamTipoCbte'       : FEXGetParamTipoCbte.run(args)
          when 'FEXGetParamTipoExpo'       : FEXGetParamTipoExpo.run(args)
          when 'FEXGetParamUMed'           : FEXGetParamUMed.run(args)
          else                             ; usage_exit
        end
        WSFEX::Client.test
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

                                     La sintaxis de las opciones y argumentos requeridos 
                                     dependen del servicio a utilizar.
                                     Escriba wsfe <servicio> --info para obtener mayor
                                     informacion acerca de un servicio en particular.
__EOD__
      end
    end
  end
end
