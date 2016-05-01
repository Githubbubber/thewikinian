require 'pg'

conn = PG.connect(dbname: "thewikinian")

conn.exec("DROP TABLE IF EXISTS categories")

conn.exec("CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  a_id INTEGER NOT NULL,
  tag VARCHAR(15) NOT NULL
  )"
)

conn.exec("INSERT INTO categories (a_id, tag) VALUES (1, 'Documents')")
conn.exec("INSERT INTO categories (a_id, tag) VALUES (2, 'Events')")
conn.exec("INSERT INTO categories (a_id, tag) VALUES (3, 'Happy Hour')")
conn.exec("INSERT INTO categories (a_id, tag) VALUES (3, 'Vacation time')")
conn.exec("INSERT INTO categories (a_id, tag) VALUES (3, 'Events')")
