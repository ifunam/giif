# module ClassMethods
module ActionView
  module Helpers
    class FormBuilder
      def simple_select(model_name, id=nil)
        field_name = Inflector.foreign_key(model_name)
        select(field_name, model_name.find(:all).collect { |record| [record.name, record.id] }, :prompt => '--Seleccionar--', :selected => id)
      end
    end
  end
end
# end
# include ClassMethods
# ActionView::Helpers::FormBuilder.extend(ClassMethods)
