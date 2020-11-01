require 'rails_helper'

RSpec.describe Article, type: :model do
  it { is_expected.to have_many(:product_articles).with_primary_key(:code).with_foreign_key(:article_code) }
end
