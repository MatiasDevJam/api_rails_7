class Order < ApplicationRecord
  belongs_to :user
  
  validates_with EnoughProductsValidator

end
