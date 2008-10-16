module WSFE

class Response
  attr_accessor :value, :errCode, :errMsg

  def initialize(soap_response, result, fieldname)
    result = soap_response.respond_to?(result) ? soap_response.send(result) : nil
    if result
      value = result.respond_to?(fieldname) ? result.send(fieldname) : 0
      value = value.respond_to?(:value) ? value.value.to_i : value.to_i
      errCode = result.rError.percode.to_i
      errMsg = result.rError.perrmsg
    else
      value = 0
      errCode = -1
      errMsg = ''
    end
    @value = value
    @errCode = errCode
    @errMsg = errMsg
  end

  def save(file)
    out = File.new(file, 'w')
    out.write "[Respuesta]\n"
    out.write "valor=#{value}\n"
    out.write "errCode=#{errCode}\n"
    out.write "errMsg=#{errMsg}\n"
    out.close
  end
end

end
