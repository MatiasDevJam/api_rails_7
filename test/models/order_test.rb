require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "an order should command not too much product than available" do
    @order.placements << Placement.new(product_id: @product1.id, quantity: (1 + @product1.quantity))
    assert_not @order.valid?
  end
  
end
