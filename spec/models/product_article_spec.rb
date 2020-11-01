require 'rails_helper'

RSpec.describe ProductArticle, type: :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:article).with_primary_key(:code).with_foreign_key(:article_code).optional }
end
