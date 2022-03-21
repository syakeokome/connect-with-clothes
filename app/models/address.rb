class Address < ApplicationRecord
  def get_full_address
    postal_code + ' ' + address + ' ' + name
  end
  belongs_to :user
end
