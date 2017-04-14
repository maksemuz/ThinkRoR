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
        history ||= instance_variable_get(var_history).last
        history << value
        instance_variable_set(var_history, history)
      end
    end
  end

  def strong_attr_acessor(name, attr_class)
    var_name = "@#{name}".to_sym
    puts "attr = #{var_name}, attr_class = #{attr_class}, cls_a = #{attr_class.class}"
    ## getter
    define_method(name) { instance_variable_get(var_name) }

    ## setter & checker
    define_method("#{name}=".to_sym) do |attr|
      raise ArgumentError, "Неверный класс #{attr.class} аргумента #{attr}, должен быть #{attr_class}" unless attr.is_a?(attr_class)
      instance_variable_set(var_name, attr)
    end
  end
end
