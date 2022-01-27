require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "an order should command not too much product than available" do
    @order.placements << Placement.new(product_id: @product1.id, quantity: (1 + @product1.quantity))
    assert_not @order.valid?
  end

  test "Should set total" do
    @order.placements = [
    Placement.new(product_id: @product1.id, quantity: 2),
    Placement.new(product_id: @product2.id, quantity: 2)
    ]
    @order.set_total!
    expected_total = (@product1.price * 2) + (@product2.price * 2)
    assert_equal expected_total, @order.total
    end
  
end
