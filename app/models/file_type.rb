class FileType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  def valid_params
    @params = { :name => ''}
  end

  def build_valid
    @file_type = FyleType.new(@params)
  end
end
