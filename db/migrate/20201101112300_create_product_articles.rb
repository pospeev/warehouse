class CreateProductArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :product_articles do |t|
      t.references :product
      t.string :article_code
      t.integer :amount

      t.timestamps
    end
  end
end
