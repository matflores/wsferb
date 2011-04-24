#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/options"

module WSFErb
  module WSFE
    module Runner
      def self.run(*args)
        silence_warnings do
          puts "hey"
        end
      end
    end
  end
end

require "wsferb/wsfe/runner/base"

Dir[File.join(File.dirname(__FILE__), "runner", "*.rb")].each { |file| require file }
