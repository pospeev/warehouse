class Article < ApplicationRecord
  has_many :product_articles, primary_key: :code, foreign_key: :article_code
end
