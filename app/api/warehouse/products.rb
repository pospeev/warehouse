module Warehouse
  class Products < Grape::API
    resource :products do
      # GET /products
      desc 'Get all the products with their available quantity', success: Warehouse::Entities::Product
      get do
        products = Product.with_available_quantity
        present products, with: Warehouse::Entities::Product
      end

      route_param :id do
        # POST /products/1/sell
        desc 'Sell a product'
        params do
          requires :quantity, type: Integer
        end
        post :sell do
          product = Product.with_available_quantity.find(params[:id])
          product.sell!(quantity: params[:quantity])

          { success: :success }
        rescue Product::NotEnoughInStockError => e
          error!(e.message, 422)
        end
      end
    end
  end
end
