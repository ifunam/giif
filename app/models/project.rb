class Project < ActiveRecord::Base
  validates_presence_of :project_type_id, :name, :key
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :order
end
