$: << File.expand_path(File.dirname(__FILE__) + "/../src/lib")

require 'rubygems'
require 'protest'
require 'wsaa'
require 'wsfe'
require 'wsfex'

WSAA::Client.enable_test_mode
WSFE::Client.enable_test_mode
WSFEX::Client.enable_test_mode

CERT_FILE = File.join File.dirname(__FILE__), 'credentials', '20238883890.crt'
KEY_FILE  = File.join File.dirname(__FILE__), 'credentials', '20238883890.key'

Protest.report_with(:documentation)
