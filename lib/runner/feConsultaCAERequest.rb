module WSFE
  module Runner
    class FEConsultaCAERequest < Base
      def main
        info_exit unless @options.cuit
        info_exit unless @options.out
        info_exit unless @cae && @cuit_emisor && @tipo_cbte && @punto_vta && @nro_cbte && @total && @fecha
        ticket = obtieneTicket
        WSFE::Client.verificaCAE(ticket, @cae, @cuit_emisor, @punto_vta, @tipo_cbte, @nro_cbte, @total, @fecha).save(@options.out)
      end

      def load_options(argv)
        super
        info_exit if argv.size < 8
        @cae = argv[1].dup
        @cuit_emisor = argv[2].dup
        @tipo_cbte = argv[3].dup
        @punto_vta = argv[4].dup
        @nro_cbte = argv[5].dup
        @total = argv[6].dup
        @fecha = argv[7].dup
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEConsultaCAERequest <cae> <cuit-emisor> <tipo-cbte> <punto-vta> <nro-cbte> <total> <fecha>"
        parser.separator ""
        parse_authentication_options
        parse_common_options
#  <cae>           CAE a verificar
#  <cuit-emisor>   cuit emisor del comprobante
#  <tipo-cbte>     tipo de comprobante (ver tabla AFIP)
#  <punto-vta>     punto de venta
#  <nro-cbte>      nro de comprobante
#  <total>         importe total de la operacion o lote
#  <fecha>         fecha del comprobante (AAAAMMDD)
      end
    end
  end
end
