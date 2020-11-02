module Warehouse
  class Inventory < Grape::API
    resource :inventory do
      # GET /inventory
      desc 'Get all the articles', success: Warehouse::Entities::Article
      get do
        articles = Article.all
        present articles, with: Warehouse::Entities::Article
      end
    end
  end
end
