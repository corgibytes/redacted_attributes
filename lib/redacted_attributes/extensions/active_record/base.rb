module ActiveRecord
  class Base
    class << self
      def attr_redacted(*params)
        define_attribute_methods rescue nil

        if const_defined?(:RedactedAttributes, _search_ancestors = false)
          mod = const_get(:RedactedAttributes)
        else
          mod = const_set(:RedactedAttributes, Module.new)
          include mod
        end

        params.each do |attribute|
          mod.module_eval(<<-REDACTED, __FILE__, __LINE__ + 1)
            def #{attribute}=(value)
              if value
                self.redacted_#{attribute} = value[0..2]
              end
              super(value)
            end
          REDACTED
        end
      end
    end
  end
end
