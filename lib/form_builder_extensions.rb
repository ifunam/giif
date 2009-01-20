# module ClassMethods
module ActionView
  module Helpers
    class FormBuilder
      include AutoComplete
      def simple_select(model_name, id=nil)
        field_name = ActiveSupport::Inflector.foreign_key(model_name) #TODO: change to ActiveSupport::Inflector because Inflector is deprecated
        select(field_name, model_name.find(:all, :order => 'id').collect { |record| [record.name, record.id] }, :prompt => '--Seleccionar--', :selected => id)
      end
    end
  end
end
# end
# include ClassMethods
# ActionView::Helpers::FormBuilder.extend(ClassMethods)
