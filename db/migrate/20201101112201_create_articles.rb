class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :code
      t.string :name
      t.integer :stock

      t.timestamps
    end
  end
end
