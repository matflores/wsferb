#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
class Hash
  def stringify_keys
    {}.tap do |hash|
      each do |k, v|
        hash[normalize_key(k)] = normalize_value(v)
      end
    end
  end

  def normalize_key(key)
    k = key.to_s
    k[":"] ? k : "n1:#{k}"
  end

  def normalize_value(value)
    case value
    when Array
      value.map { |e| normalize_value(e) }
    when Hash
      value.stringify_keys
    else
      value
    end
  end
end
