require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to have_many(:product_articles) }
  it { should accept_nested_attributes_for(:product_articles) }
  it { is_expected.to have_many(:articles).through(:product_articles) }

  describe ".with_available_quantity" do
    before do
      Product.create({
        name: "Dinning Table",
        product_articles_attributes: [
          { article_code: "1", amount: 4 },
          { article_code: "2", amount: 8 },
          { article_code: "4", amount: 1 }
        ]
      })
    end

    context "when all article are in stock" do
      subject { Product.with_available_quantity.first }

      before do
        Article.create([
          { code: "1", name: "leg", stock: 12 },
          { code: "2", name: "screw", stock: 17 },
          { code: "4", name: "table top", stock: 1 }
        ])
      end

      it "shows the proper available quantity of the product" do
        expect(subject.available_quantity).to eq(1)
      end
    end

    context "when one article is missing" do
      subject { Product.with_available_quantity.first }

      before do
        Article.create([
          { code: "1", name: "leg", stock: 3 },
          { code: "2", name: "screw", stock: 17 },
          { code: "4", name: "table top", stock: 1 }
        ])
      end

      it "shows zero available quantity of the product" do
        expect(subject.available_quantity).to eq(0)
      end
    end


    context "when no article is present" do
      subject { Product.with_available_quantity.first }

      it "shows zero available quantity of the product" do
        expect(subject.available_quantity).to eq(0)
      end
    end
  end
end
