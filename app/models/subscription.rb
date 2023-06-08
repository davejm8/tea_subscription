class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea
  enum status: [:active, :pending, :cancelled]
  enum frequency: [:weekly, :biweekly, :monthly]
  validates_presence_of :title, :price, :status, :frequency, :customer_id, :tea_id
end
