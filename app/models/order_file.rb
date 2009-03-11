class OrderFile < ActiveRecord::Base
  validates_presence_of :file_type_id, :file
  belongs_to :order
  belongs_to :file_type
  
  after_validation :read_file
  
  #def read_file
  #    content_type = file.content_type
  #    filename =  file.original_filename
  #    file = file.class.name
  #end  
end
