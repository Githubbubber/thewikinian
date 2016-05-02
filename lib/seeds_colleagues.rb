require 'faker'
require 'pg'

conn = PG.connect(dbname: "thewikinian")

conn.exec("DROP TABLE IF EXISTS colleagues")

conn.exec("CREATE TABLE colleagues (
  id SERIAL PRIMARY KEY,
  username VARCHAR(25) UNIQUE NOT NULL,
  password VARCHAR(225) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  profile_pic VARCHAR(225)
  )"
)

5.times do
  colleague_username = Faker::Internet.user_name
  colleague_password = Faker::Internet.password(8, 15) # Min: 8, max: 15
  colleague_email = Faker::Internet.email
  colleague_pp = Faker::Avatar.image

  conn.exec_params("INSERT INTO colleagues (username, password, email, profile_pic) VALUES ($1, $2, $3, $4)",
    [colleague_username, colleague_password, colleague_email, colleague_pp])
end
