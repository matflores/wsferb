$: << File.expand_path(File.dirname(__FILE__) + "/../src/lib")

require 'wsaa'
require 'wsfe'

WSFE::Client.enable_test_mode
WSAA::Client.enable_test_mode
