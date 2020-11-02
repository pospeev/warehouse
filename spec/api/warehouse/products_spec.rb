require 'rails_helper'

describe Warehouse::Products do
  context 'GET /products' do
    let!(:product) do
      Product.create({
        name: 'Dinning Table',
        product_articles_attributes: [
          { article_code: '1', amount: 4 },
          { article_code: '2', amount: 8 },
          { article_code: '4', amount: 1 }
        ]
      })
    end

    context 'when all articles are in stock' do
      before do
        Article.create([
          { code: '1', name: 'leg', stock: 12 },
          { code: '2', name: 'screw', stock: 17 },
          { code: '4', name: 'table top', stock: 1 }
        ])
      end

      let(:expected_response) do
        [
          {
            'id' => product.id,
            'name' => product.name,
            'available_quantity' => 1,
            'created_at' => product.created_at.iso8601(3),
            'updated_at' => product.updated_at.iso8601(3)
          }
        ]
      end

      it 'returns the products with 1 as available quantity' do
        get '/products'

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end

    context 'when one article is missing' do
      before do
        Article.create([
          { code: '1', name: 'leg', stock: 3 },
          { code: '2', name: 'screw', stock: 17 },
          { code: '4', name: 'table top', stock: 1 }
        ])
      end

      let(:expected_response) do
        [
          {
            'id' => product.id,
            'name' => product.name,
            'available_quantity' => 0,
            'created_at' => product.created_at.iso8601(3),
            'updated_at' => product.updated_at.iso8601(3)
          }
        ]
      end

      it 'returns the products with 0 as available quantity' do
        get '/products'

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end

    context 'when no article is present' do
      let(:expected_response) do
        [
          {
            'id' => product.id,
            'name' => product.name,
            'available_quantity' => 0,
            'created_at' => product.created_at.iso8601(3),
            'updated_at' => product.updated_at.iso8601(3)
          }
        ]
      end

      it 'returns the products with 0 as available quantity' do
        get '/products'

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end
  end

  context 'POST /products/:id/sell' do
    let!(:product) do
      Product.create({
        name: 'Dinning Table',
        product_articles_attributes: [
          { article_code: '1', amount: 4 },
          { article_code: '2', amount: 8 },
          { article_code: '4', amount: 1 }
        ]
      })
    end

    context 'when all articles are in stock' do
      let!(:article1) { Article.create({ code: '1', name: 'leg', stock: 12 }) }
      let!(:article2) { Article.create({ code: '2', name: 'screw', stock: 17 }) }
      let!(:article3) { Article.create({ code: '4', name: 'table top', stock: 1 }) }

      it 'changes the stock for each item' do
        expect do
          post "/products/#{product.id}/sell", params: { quantity: 1 }, as: :json
        end.to change { Product.find(product.id).available_quantity }.from(1).to(0)
          .and change { article1.reload.stock }.from(12).to(8)
          .and change { article2.reload.stock }.from(17).to(9)
          .and change { article3.reload.stock }.from(1).to(0)

        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)).to eq({ 'success' => 'success' })
      end
    end

    context 'when one article is missing' do
      let!(:article1) { Article.create({ code: '1', name: 'leg', stock: 3 }) }
      let!(:article2) { Article.create({ code: '2', name: 'screw', stock: 17 }) }
      let!(:article3) { Article.create({ code: '4', name: 'table top', stock: 1 }) }

      it 'changes the stock for each item' do
        expect do
          post "/products/#{product.id}/sell", params: { quantity: 1 }, as: :json
        end.to change { Product.find(product.id).available_quantity }.by(0)
          .and change { article1.reload.stock }.by(0)
          .and change { article2.reload.stock }.by(0)
          .and change { article3.reload.stock }.by(0)

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'There are not enough products available in stock' })
      end
    end
  end
end
