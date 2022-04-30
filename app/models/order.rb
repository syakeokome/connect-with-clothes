class Order < ApplicationRecord
   belongs_to :user
   belongs_to :item
   enum payment_method: { credit_card: 0, transfer: 1 }
   
   validates :payment_method, presence: true
end
