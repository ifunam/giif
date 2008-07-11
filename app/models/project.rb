class Project < ActiveRecord::Base
  validates_presence_of :name, :project_type_id
end
