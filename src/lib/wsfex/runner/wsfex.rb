#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class Wsfex < Base
      def run(argv)
        args = argv.dup
        load_options(argv)
        service = find_service(argv.shift)
        service ? service.run(args) : usage_exit
      end

      def find_service(service_name)
        service_name = WSFEX::Runner.constants.detect { |constant| constant =~ /#{service_name}/i }
        service_name ? WSFEX::Runner.const_get(service_name) : nil
      end

      def parse_options
        parser.banner = "Modo de uso: wsfex [opciones] <servicio> [argumentos]"
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
Modo de uso: wsfex [opciones] <servicio> [argumentos]

     servicio                        Uno de los servicios provistos por el WSFEX de AFIP.
                                     Valores posibles:
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
                                     Escriba wsfex <servicio> --help para obtener mayor
                                     informacion acerca de un servicio en particular.
__EOD__
      end
    end
  end
end
