#
# wsfe.rb: Web Services Facturación Electrónica AFIP
# Copyright (C) 2008 Matiás Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module VERSION
    unless defined? MAJOR
      MAJOR  = 1
      MINOR  = 0
      TINY   = 0
      RELEASE_CANDIDATE = nil

      STRING = [MAJOR, MINOR, TINY].join('.')
      TAG = "REL_#{[MAJOR, MINOR, TINY, RELEASE_CANDIDATE].compact.join('_')}".upcase.gsub(/\.|-/, '_')
      FULL_VERSION = "#{[MAJOR, MINOR, TINY, RELEASE_CANDIDATE].compact.join('.')}"

      NAME   = "wsfe"
      URL    = "mflores@atlanware.com"  
    
      DESCRIPTION = "#{NAME}-#{FULL_VERSION} - Web Services Facturación Electrónica AFIP"
    end
  end
end

