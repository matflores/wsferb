$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'wsaa'
require 'wsfe'

WSFE::Client.enable_test_mode
WSAA::Client.enable_test_mode
