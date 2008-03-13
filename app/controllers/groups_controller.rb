class GroupsController < SimpleModelController
  def initialize
    @model = Group
    @params_key =  Inflector.tableize(@model).singularize.to_sym # :group
  end
end
