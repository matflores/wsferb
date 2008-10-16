module WSFE
  module Runner
    class Options

      attr_accessor(
        :cuit,
        :ticket,
        :cert,
        :key,
        :out,
        :xml,
        :servicios,
        :argv
      )
        
        def add_example_group(example_group)
          @example_groups << example_group
        end

        def remove_example_group(example_group)
          @example_groups.delete(example_group)
        end

        def run_examples
          return true unless examples_should_be_run?
          success = true
          begin
            before_suite_parts.each do |part|
              part.call
            end
            runner = custom_runner || ExampleGroupRunner.new(self)

            unless @files_loaded
            runner.load_files(files_to_load)
            @files_loaded = true
          end

          if example_groups.empty?
            true
          else
            set_spec_from_line_number if line_number
            success = runner.run
            @examples_run = true
            heckle if heckle_runner
            success
          end
        ensure
          after_suite_parts.each do |part|
            part.call(success)
          end
        end
      end

      def cuit=(cuit)
        @cuit = cuit
        @cert ||= "./#{@cuit}.crt"
        @key ||= "./#{@cuit}.key"
        @xml ||= "./#{@cuit}.xml"
      end
    end
  end
end
