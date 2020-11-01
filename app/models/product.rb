class Product < ApplicationRecord
  has_many :product_articles
  accepts_nested_attributes_for :product_articles

  has_many :articles, through: :product_articles, foreign_key: :article_code

  # The scope below produces this query:
  # SELECT products.*,
  #        MIN(articles.stock / product_articles.amount) AS available_quantity
  # FROM "products"
  # INNER JOIN "product_articles" ON "product_articles"."product_id" = "products"."id"
  # INNER JOIN "articles" ON "articles"."code" = "product_articles"."article_code"
  # GROUP BY products.id
  scope :with_available_quantity, -> {
    select("products.*, MIN(articles.stock / product_articles.amount) AS available_quantity")
      .joins(:articles)
      .group("products.id")
  }
end
