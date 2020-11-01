class Product < ApplicationRecord
  has_many :product_articles
  accepts_nested_attributes_for :product_articles

  has_many :articles, through: :product_articles, foreign_key: :article_code

  # The scope below produces this query:
  # SELECT products.*,
  #        COALESCE(MIN(articles.stock / product_articles.amount), 0) AS available_quantity
  # FROM "products"
  # LEFT OUTER JOIN "product_articles" ON "product_articles"."product_id" = "products"."id"
  # LEFT OUTER JOIN "articles" ON "articles"."code" = "product_articles"."article_code"
  # GROUP BY products.id
  scope :with_available_quantity, -> {
    select("products.*, COALESCE(MIN(articles.stock / product_articles.amount), 0) AS available_quantity")
      .left_joins(:articles)
      .group("products.id")
  }
end
