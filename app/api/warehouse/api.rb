require 'grape-swagger'

module Warehouse
  class API < Grape::API
    content_type :json, 'application/json'
    default_format :json

    rescue_from ActiveRecord::RecordNotFound do
      error!('Not found', 404)
    end

    mount Warehouse::Products
    mount Warehouse::Inventory

    add_swagger_documentation
  end
end
