# Module of validators

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Methods to be extended
  module ClassMethods
    def validate(attr, validator, arg = nil)
      @validations ||= []
      @validations << { attr: attr, validator: validator, arg: arg }
    end
  end

  # Methds to be included
  module InstanceMethods
    def validate!
      self.class.get_validations.each do |val|
        attribute = instance_variable_get("@#{val[:attr]}".to_sym)
        send(val[:validator], attribute, val[:arg])
      end
    end

    def valid?
      validate!
      true
    rescue => err_msg
      puts err_msg
    end

    def presence(attr, _val)
      raise ArgumentError, "Объект #{self}: Пустой атрибут" if attr.nil? || attr.empty?
    end

    def format(attr, format)
      raise ArgumentError, "Объект #{self}: Неверный формат атрибута" unless attr.match?(format)
    end

    def type(attr, klass)
      raise ArgumentError, "Объект #{self}: Неверный класс атрибута" unless attr.is_a?(klass)
    end

    def existance(attr, _val)
      raise ArgumentError, "Объект #{self}: Такой объект уже есть." if self.class.all.key?(attr)
    end
  end
end
