class Permission < ActiveRecord::Base
  validates_presence_of :order_status_id, :controller_id, :actions, :title

  belongs_to :order_status
  belongs_to :controller

end
