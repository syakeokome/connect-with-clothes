class Order < ApplicationRecord
   belongs_to:user
   enum payment_method: { credit_card: 0, transfer: 1 }
end
