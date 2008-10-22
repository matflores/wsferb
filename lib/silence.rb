#
# Web Services Facturación Electrónica AFIP
# Copyright (C) 2008 Matiás Alejandro Flores <mflores@atlanware.com>
#
module Kernel
  def silence_warnings
    old_verbose, $VERBOSE = $VERBOSE, nil
    yield
  ensure
    $VERBOSE = old_verbose
  end
end
