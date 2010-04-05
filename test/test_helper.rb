$: << File.expand_path(File.dirname(__FILE__) + "/../src/lib")

require 'rubygems'
require 'protest'
require 'wsaa'
require 'wsfe'

WSFE::Client.enable_test_mode
WSAA::Client.enable_test_mode

Protest.report_with(:documentation)
