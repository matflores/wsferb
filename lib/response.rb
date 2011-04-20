#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
class Response
  attr_accessor :response

  def initialize(response = {})
    @response = Hash === response ? response : response.to_hash
    @errors = []
    @events = []
  end

  def errors
    @errors ||= []
  end

  def events
    @events ||= []
  end

  def add_error(code, message)
    errors << { :code => code, :message => message }
  end

  def add_event(code, message)
    events << { :code => code, :message => message }
  end

  def has_error?(code)
    errors.any? { |e| e[:code] == code }
  end

  def has_event?(code)
    events.any? { |e| e[:code] == code }
  end

  def failed?
    errors.any? { |e| e[:code] > 0 }
  end

  def success?
    !failed?
  end

  def to_s
    [].tap do |output|
      output << errors.map { |e| ("E%06d%-512s" % [ e[:code], e[:message] ]).strip } unless errors.empty?
      output << events.map { |e| ("V%06d%-512s" % [ e[:code], e[:message] ]).strip } unless events.empty?
    end.join("\n")
  end
end
