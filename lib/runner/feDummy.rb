module WSFE
  module Runner
    class FEDummy < Base
      def main
        r = WSFE::Client.test
        if @options.out && !@options.out.empty?
          File.open(@options.out, 'w') { |f| f.puts(r) }
        else
          puts r
        end
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEDummy"
        parser.separator ""
        parse_common_options
      end
    end
  end
end
