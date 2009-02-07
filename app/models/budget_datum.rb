class BudgetDatum < ActiveRecord::Base
  validates_presence_of :order_id, :user_id, :code, :previous_number, :external_account

  belongs_to :order
end
