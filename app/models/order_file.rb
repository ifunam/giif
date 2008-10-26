class OrderFile < ActiveRecord::Base
  validates_presence_of :file_type_id, :file, :content_type, :filename
  belongs_to :order
  belongs_to :file_type
end
