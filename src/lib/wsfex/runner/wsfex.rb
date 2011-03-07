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
          when 'FEXAuthorize'              then FEXAuthorize.run(args)
          when 'FEXCheckPermiso'           then FEXCheckPermiso.run(args)
          when 'FEXDummy'                  then FEXDummy.run(args)
          when 'FEXGetCmp'                 then FEXGetCmp.run(args)
          when 'FEXGetLastCmp'             then FEXGetLastCmp.run(args)
          when 'FEXGetLastId'              then FEXGetLastId.run(args)
          when 'FEXGetParamCtz'            then FEXGetParamCtz.run(args)
          when 'FEXGetParamDstCuit'        then FEXGetParamDstCuit.run(args)
          when 'FEXGetParamDstPais'        then FEXGetParamDstPais.run(args)
          when 'FEXGetParamIncoterms'      then FEXGetParamIncoterms.run(args)
          when 'FEXGetParamIdiomas'        then FEXGetParamIdiomas.run(args)
          when 'FEXGetParamMon'            then FEXGetParamMon.run(args)
          when 'FEXGetParamPtoVenta'       then FEXGetParamPtoVenta.run(args)
          when 'FEXGetParamTipoCbte'       then FEXGetParamTipoCbte.run(args)
          when 'FEXGetParamTipoExpo'       then FEXGetParamTipoExpo.run(args)
          when 'FEXGetParamUMed'           then FEXGetParamUMed.run(args)
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
