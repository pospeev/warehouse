# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Product.create([
  {
    name: "Dining Chair",
    product_articles_attributes: [
      {
        article_code: "1",
        amount: 4
      },
      {
        article_code: "2",
        amount: 8
      },
      {
        article_code: "3",
        amount: 1
      }
    ]
  },
  {
    name: "Dinning Table",
    product_articles_attributes: [
      {
        article_code: "1",
        amount: 4
      },
      {
        article_code: "2",
        amount: 8
      },
      {
        article_code: "4",
        amount: 1
      }
    ]
  }
])

Article.create([
  {
    code: "1",
    name: "leg",
    stock: 12
  },
  {
    code: "2",
    name: "screw",
    stock: 17
  },
  {
    code: "3",
    name: "seat",
    stock: 2
  },
  {
    code: "4",
    name: "table top",
    stock: 1
  }
])
