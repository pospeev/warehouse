class ProductArticle < ApplicationRecord
  belongs_to :product
  belongs_to :article, primary_key: :code, foreign_key: :article_code
end
