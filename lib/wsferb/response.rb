#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  class Response
    attr_accessor :response, :result

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

    def records
      @records ||= []
    end

    def add_error(code, message)
      errors << { :code => code.to_i, :message => message }
    end

    def add_event(code, message)
      events << { :code => code.to_i, :message => message }
    end

    def add_record(type, contents)
      records << "#{type}#{contents}"
    end

    def has_error?(code)
      errors.any? { |e| e[:code].to_i == code.to_i }
    end

    def has_event?(code)
      events.any? { |e| e[:code].to_i == code.to_i }
    end

    def failed?
      errors.any? { |e| e[:code].to_i > 0 }
    end

    def success?
      !failed?
    end

    def to_s
      (formatted_records + formatted_errors + formatted_events).join("\n")
    end

    def formatted_records
      records.map { |record| format_record(record).strip }
    end

    def format_record(record)
      record.to_s
    end

    def formatted_errors
      errors.select { |e| e[:code].to_i > 0 }.map { |e| ("E%06d%-512s" % [ e[:code].to_i, e[:message] ]).strip }
    end

    def formatted_events
      events.map { |e| ("V%06d%-512s" % [ e[:code].to_i, e[:message] ]).strip }
    end

    def value
      formatted_records.first[1..-1].strip rescue ""
    end

    def save(file)
      File.open(file, "w") { |f| f.write(to_s) }
    end

    def self.load(file)
      new.tap do |response|
        File.open(file) do |file|
          file.each_line do |line|
            record_type = line[0]
            code        = line[1..6]
            message     = line[7..-1]

            case record_type
            when "E" ; response.add_error(code, message)
            when "V" ; response.add_event(code, message)
            else     ; response.add_record(record_type, line[1..-1])
            end
          end
        end
      end
    end
  end
end
