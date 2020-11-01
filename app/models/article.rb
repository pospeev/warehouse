class Article < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :product_articles, primary_key: :code, foreign_key: :article_code, inverse_of: :article
  # rubocop:enable Rails/HasManyOrHasOneDependent
end
