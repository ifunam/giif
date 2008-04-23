class Person < ActiveRecord::Base
  validates_presence_of :lastname1, :firstname
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :greater_than => 0, :only_integer => true
  validates_inclusion_of :gender, :in => [true,false]
  validates_uniqueness_of :user_id

  belongs_to :user

  def fullname
    [self.lastname1.strip, (self.lastname2 != nil ? self.lastname2.strip : nil), self.firstname.strip].compact.join(' ')
  end
end
