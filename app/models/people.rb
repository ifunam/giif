class People < ActiveRecord::Base
  belongs_to :user

  def fullname
    [self.lastname1.strip, (self.lastname2 != nil ? self.lastname2.strip : nil), self.firstname.strip].compact.join(' ')
  end
end

