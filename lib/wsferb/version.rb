#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module Version
    unless defined? MAJOR
      MAJOR  = 2
      MINOR  = 0
      TINY   = 0
      RELEASE_CANDIDATE = ""

      STRING = [MAJOR, MINOR, TINY].join(".")
      FULL_VERSION = [MAJOR, MINOR, TINY, RELEASE_CANDIDATE].compact.join(".")

      NAME   = "WSFErb"
      URL    = "wsferb@atlanware.com"  
    
      DESCRIPTION = "#{NAME}-#{FULL_VERSION} - Web Services Facturacion Electronica AFIP"
    end
  end
end
