class DirectAdjudicationType < ActiveRecord::Base
  validates_presence_of :name

  has_many :acquisitions
end
