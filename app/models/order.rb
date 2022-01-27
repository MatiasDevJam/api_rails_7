class Order < ApplicationRecord
  belongs_to :user
  
  validates_with EnoughProductsValidator

  def set_total!
    self.total = self.placements.map{ |placement| placement.product.price * placement.quantity }.sum
  end
  

end
