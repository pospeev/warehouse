module Warehouse
  module Entities
    class Article < Grape::Entity
      expose :id, documentation: { type: Integer, desc: 'Article ID' }
      expose :code, documentation: { type: String, desc: 'Article Code' }
      expose :name, documentation: { type: String, desc: 'Article Name' }
      expose :stock, documentation: { type: Integer, desc: 'Stock Availability' }
      expose :created_at, documentation: { type: DateTime, desc: 'Created At' }
      expose :updated_at, documentation: { type: DateTime, desc: 'Updated At' }
    end
  end
end
