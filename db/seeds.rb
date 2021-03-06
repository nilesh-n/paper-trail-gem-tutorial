# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

article = Article.create(title: "Version 1", body: Faker::Lorem.paragraph)

2.upto(6) do |i|
  article.update(title: "Version #{i}")
end

1.upto(2) do |i|
  deleted_article = Article.create(title: "Deleted Article #{i}", body: Faker::Lorem.paragraph)
  deleted_article.destroy
  deleted_article = Article.new(id: deleted_article.id).versions.last.reify
  deleted_article.save
  deleted_article.update(title: "Deleted Article #{i} Version 2")
  deleted_article.destroy
end

restored_article = Article.create(title: 'A previously deleted article', body: Faker::Lorem.paragraph)
restored_article.destroy
restored_article = Article.new(id: restored_article.id).versions.last.reify
restored_article.save

a = Article.create(title: 'foo', body: Faker::Lorem.paragraph)
comment_1 = a.comments.create(body: 'comment 1')
comment_2 = a.comments.create(body: 'comment 2')

comment_1.notes.create(body: 'comment 1 - note 1')
comment_1.notes.create(body: 'comment 1 - note 2')

comment_2.notes.create(body: 'comment 2 - note 1')
