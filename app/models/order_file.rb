class OrderFile < ActiveRecord::Base
  def initialize
    @upload_file = OrderFile.new()
  end

  def order_file=(input_data)
    self.file_name = input_data.original_filename
    self.content_type = input_data.content_type.chomp
    self.file = input_data.read
  end
end
