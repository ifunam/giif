class OrderFile < ActiveRecord::Base
  has_attached_file :file

  validates_presence_of :order_id,:file_type_id
  belongs_to :order
  belongs_to :file_type 
  belongs_to :provider
end
