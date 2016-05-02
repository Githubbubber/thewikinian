require 'pg'

if ENV["RACK_ENV"] == "production"
    @conn ||= conn = PG.connect(
        dbname: ENV["POSTGRES_DB"],
        host: ENV["POSTGRES_HOST"],
        password: ENV["POSTGRES_PASS"],
        user: ENV["POSTGRES_USER"]
     )
else
    conn = PG.connect(dbname: "thewikinian")
end

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
