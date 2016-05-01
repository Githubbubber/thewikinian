require 'faker'
require 'pg'

conn = PG.connect(dbname: "thewikinian")

conn.exec("DROP TABLE IF EXISTS articles")

conn.exec("CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  author VARCHAR(25) NOT NULL,
  original_body TEXT NOT NULL
  )"
) # Break categories up into table

5.times do
  article_title = Faker::Hipster.sentence
  article_author = Faker::Internet.user_name
  article_ob = Faker::Hipster.paragraph(2)

  conn.exec_params("INSERT INTO articles (title, author, original_body) VALUES ($1, $2, $3)",
    [article_title, article_author, article_ob])
end
