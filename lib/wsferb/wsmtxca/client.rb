#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "time"
require "savon"

module WSFErb
  module WSMTXCA
    class Client
      def self.dummy
        response = client.request(:dummy)
        "1#{response.to_hash[:dummy_response][:dummy_result][:auth_server]}#{response.to_hash[:dummy_response][:dummy_result][:app_server]}#{response.to_hash[:dummy_response][:dummy_result][:db_server]}"
      end

      def self.client
        options = { :wsdl           => File.join(File.dirname(__FILE__), "/wsmtxca.wsdl"),
                    :production_url => "https://serviciosjava.afip.gob.ar/wsmtxca/services/MTXCAService",
                    :testing_url    => "https://fwshomo.afip.gov.ar/wsmtxca/services/MTXCAService" }

        @client ||= WSFErb.client(options)
      end
    end
  end
end
