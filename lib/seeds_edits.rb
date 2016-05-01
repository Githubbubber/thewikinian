require 'pg'

conn = PG.connect(dbname: "thewikinian")

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
