class Project < ActiveRecord::Base
  validates_presence_of :project_type_id, :name, :key, :order_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :order
  belongs_to :project_type
end
