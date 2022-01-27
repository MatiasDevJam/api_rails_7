class Api::V1::OrdersController < ApplicationController
    include Paginable

    before_action :check_login, only: %i[index show create]

    def index
    
        @orders = current_user.orders.page(current_page).per(per_page)
        
        options = get_links_serializer_options('api_v1_orders_path', @orders)
        
        render json: OrderSerializer.new(current_user.orders, options).serializable_hash
    end

    def show
        order = current_user.orders.find(params[:id])
        
        if order
            options = { include: [:products] }
            render json: OrderSerializer.new(order, options).serializable_hash
        else
            head 404
        end
    end

    def create
        order = current_user.orders.build(order_params)

        if order.save
            OrderMailer.send_confirmation(order).deliver 
            render json: order, status: 201
        else
            render json: { errors: order.errors }, status: 422
        end
    end

    private

    def order_params
        params.require(:order).permit(:total, product_ids: [])
    end
        
    
end
