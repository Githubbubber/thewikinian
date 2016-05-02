require 'pg'


if ENV["RACK_ENV"] == "production"
    @conn ||= PG.connect(
        dbname: ENV["POSTGRES_DB"],
        host: ENV["POSTGRES_HOST"],
        password: ENV["POSTGRES_PASS"],
        user: ENV["POSTGRES_USER"]
     )
else
    conn = PG.connect(dbname: "thewikinian")
end

conn.exec("DROP TABLE IF EXISTS timestamps")

conn.exec("CREATE TABLE timestamps (
  id SERIAL PRIMARY KEY,
  a_id INTEGER NOT NULL,
  orig_post_ts TIMESTAMP NOT NULL,
  latest_post_ts TIMESTAMP NOT NULL
  )"
)

5.times do |x|
  conn.exec "INSERT INTO timestamps (a_id, orig_post_ts, latest_post_ts) VALUES (#{x + 1}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)"
end


# postdatetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
