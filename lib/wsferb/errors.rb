#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  # Base class for all WSFErb errors
  class Error < StandardError
    def to_s
      "E%06d%s" % [ error_code, error_message ]
    end
  end

  # 900000 - Generic WSFErb errors
  class GenericError < Error
    attr_reader :error_message

    def initialize(error_message)
      @error_message = error_message
    end

    def error_code
      "900000"
    end
  end

  # 900001 - Invalid service
  class InvalidService < Error
    attr_accessor :service

    def initialize(service)
      @service = service
    end

    def error_code
      "900001"
    end

    def error_message
      "Servicio no valido: #{service}"
    end
  end

  # 900002 - CUIT missing
  class CuitMissing < Error
    def error_code
      "900002"
    end

    def error_message
      "CUIT no informado"
    end
  end

  # 900003 - Certificate not found
  class CertificateNotFound < Error
    attr_accessor :cert_file

    def initialize(cert_file)
      @cert_file = cert_file
    end

    def error_code
      "900003"
    end

    def error_message
      "Certificado no encontrado: #{cert_file}"
    end
  end

  # 900004 - Private key not found
  class PrivateKeyNotFound < Error
    attr_accessor :key_file

    def initialize(key_file)
      @key_file = key_file
    end

    def error_code
      "900004"
    end

    def error_message
      "Clave privada no encontrada: #{key_file}"
    end
  end

  # 900005 - Ticket missing
  class TicketMissing < Error
    def error_code
      900005
    end

    def error_message
      "No se pudo obtener un ticket de acceso"
    end
  end

  # 900006 - Invalid directory
  class InvalidDir < Error
    attr_accessor :dir

    def initialize(dir)
      @dir = dir
    end

    def error_code
      "900006"
    end

    def error_message
      "Directorio no valido: #{dir}"
    end
  end

  # 900007 - Argument error
  class ArgumentError < GenericError
    def error_code
      "900007"
    end
  end
end
