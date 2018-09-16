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
conn.exec("DROP TABLE IF EXISTS edits")

conn.exec("CREATE TABLE edits (
  id SERIAL PRIMARY KEY,
  a_id INTEGER NOT NULL,
  c_id INTEGER NOT NULL,
  latest_body TEXT NOT NULL
  )"
)

placeholder = 'edited'

5.times do |x|
  conn.exec_params("INSERT INTO edits (a_id, c_id, latest_body) VALUES ($1, $2, $3)", [x+1, x+1, placeholder])
end


# postdatetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
