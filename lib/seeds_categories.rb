require 'pg'

conn = PG.connect(dbname: "thewikinian")

conn.exec("DROP TABLE IF EXISTS categories")

conn.exec("CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  a_id INTEGER NOT NULL,
  tag VARCHAR(15) NOT NULL
  )"
)

5.times do |x|
  conn.exec("INSERT INTO categories (a_id, tag) VALUES (#{x+1}, 'Documents')")
end
