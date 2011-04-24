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
    (formatted_records + formatted_errors + formatted_events).join("\n")
  end

  protected

  def formatted_records
    []
  end

  def formatted_errors
    errors.map { |e| ("E%06d%-512s" % [ e[:code], e[:message] ]).strip }
  end

  def formatted_events
    events.map { |e| ("V%06d%-512s" % [ e[:code], e[:message] ]).strip }
  end
end
