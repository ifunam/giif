class OrderFile < ActiveRecord::Base
  has_attached_file :file

  validates_presence_of :file_type_id, :file
  belongs_to :order
  belongs_to :file_type 
end
