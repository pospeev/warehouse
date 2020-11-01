module Warehouse
  module Entities
    class Product < Grape::Entity
      expose :id, documentation: { type: Integer, desc: 'Product ID' }
      expose :name, documentation: { type: String, desc: 'Product Name' }
      expose :available_quantity, documentation: { type: Integer, desc: 'Available Quantity' }
      expose :created_at, documentation: { type: DateTime, desc: 'Created At' }
      expose :updated_at, documentation: { type: DateTime, desc: 'Updated At' }
    end
  end
end

