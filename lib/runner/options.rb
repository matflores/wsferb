module WSFE
  module Runner
    class Options
      attr_accessor :cuit, :ticket, :cert, :key, :out, :xml, :servicios, :argv
        
      def cuit=(cuit)
        @cuit = cuit
        @cert ||= "./#{@cuit}.crt"
        @key ||= "./#{@cuit}.key"
        @xml ||= "./#{@cuit}.xml"
      end
    end
  end
end
