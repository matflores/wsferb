#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    module Runner
      def self.run(*args)
        silence_warnings do
          puts "hey"
        end
      end
    end
  end
end

require "wsferb/wsfex/runner/base"

Dir[File.join(File.dirname(__FILE__), "runner", "*.rb")].each { |file| require file }
