class Provider < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  class << self
    def valid_options
      { :name => 'Anonymous Provider' }
    end

    def build_valid
      Provider.new(Provider.valid_options)
    end
  end
end
