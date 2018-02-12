class Post < ActiveRecord::Base

  validates :title,
      presence: true,
      length: { minimum: 8 },
      format: { with: /[A-Za-z0-9._]/ }

  validates :author,
      presence: true,
      length: { minimum: 4 },
      format: { with: /[A-Za-z0-9._]/ }

  validates :content,
      presence: true,
      length: { minimum: 8 },
      format: { with: /[\s\w.!\-,:;\']/ }
end
