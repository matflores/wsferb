require "savon"
require "core_ext/kernel"

silence_warnings do
  Savon::SOAP::DateTimeRegexp = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$/
end

Savon.log = false
HTTPI.log = false
