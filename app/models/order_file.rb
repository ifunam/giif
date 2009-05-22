class OrderFile < ActiveRecord::Base
  has_attached_file :file

  validates_presence_of :file#,:file_type_id
  belongs_to :order
  belongs_to :file_type 
end
