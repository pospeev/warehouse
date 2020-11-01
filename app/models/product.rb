class Product < ApplicationRecord
  NotEnoughInStockError = Class.new(StandardError)

  has_many :product_articles, dependent: :destroy
  accepts_nested_attributes_for :product_articles

  has_many :articles, through: :product_articles, foreign_key: :article_code

  attribute :available_quantity, :integer

  # The scope below produces this query:
  # SELECT products.*,
  #        COALESCE(MIN(articles.stock / product_articles.amount), 0) AS available_quantity
  # FROM "products"
  # LEFT OUTER JOIN "product_articles" ON "product_articles"."product_id" = "products"."id"
  # LEFT OUTER JOIN "articles" ON "articles"."code" = "product_articles"."article_code"
  # GROUP BY products.id
  scope :with_available_quantity, lambda {
    select('products.*, COALESCE(MIN(articles.stock / product_articles.amount), 0) AS available_quantity')
      .left_joins(:articles)
      .group('products.id')
  }

  def sell!(quantity: 0)
    raise NotEnoughInStockError, "There are not enough products available in stock" if quantity > available

    ActiveRecord::Base.transaction do
      articles.each do |article|
        article.stock -= quantity * product_articles.find_by(article_code: article.code).amount
        article.save!
      end
      self.available_quantity -= 1
    end
  end

  def available
    @available_quantity ||= Product.with_available_quantity.find(id).available_quantity
  end
end
