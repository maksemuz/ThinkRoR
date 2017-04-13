# Accessors module
#

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_history = "@#{name}_hist".to_sym
      history = []

      ## getter
      define_method(name) { instance_variable_get(var_name) }

      ## history getter
      define_method("#{name}_history".to_sym) { instance_variable_get(var_history) }

      ## setter & history filler
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history << value
        instance_variable_set(var_history, history)
      end
    end
  end

  def strong_attr_acessor(name, attr_class)
    var_name = "@#{name}".to_sym
    ## getter
    define_method(name) { instance_variable_get(var_name) }

    ## setter & checker
    define_method("#{name}=".to_sym) do |klass|
      raise ArgumentError, 'Неверный класс аргумента' unless name.class.is_a?(attr_class)
      instance_variable_set(var_name, klass)
    end
  end
end
