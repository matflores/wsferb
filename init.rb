#
# Web Services Facturación Electrónica AFIP
# Copyright (C) 2008 Matiás Alejandro Flores <mflores@atlanware.com>
#
$: << File.expand_path(File.dirname(__FILE__) + "/lib")

require 'wsfe'

module Kernel
  def silence_warnings
    old_verbose, $VERBOSE = $VERBOSE, nil
    yield
  ensure
    $VERBOSE = old_verbose
  end
end

silence_warnings do
  WSFE::Runner::Wsfe.run(ARGV)
end

exit 0
