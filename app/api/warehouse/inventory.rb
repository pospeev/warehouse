module Warehouse
  class Inventory < Grape::API
    resource :inventory do
      # GET /inventory
      desc 'Get all the articles', success: Warehouse::Entities::Article
      get do
        articles = Article.all
        present articles, with: Warehouse::Entities::Article
      end

      # PUT /inventory
      desc 'Upload the articles inventory', success: Warehouse::Entities::Article
      params do
        requires :inventory, type: Array do
          requires :name, type: String
          requires :art_id, type: String, as: :code
          requires :stock, type: Integer
        end
      end
      put do
        article_params = declared(params).fetch(:inventory)

        Article.upsert_all(article_params, unique_by: [:code]) # rubocop:disable Rails/SkipsModelValidations

        present Article.all, with: Warehouse::Entities::Article
      end
    end
  end
end
