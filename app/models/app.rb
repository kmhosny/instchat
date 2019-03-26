class App < ApplicationRecord
  has_secure_token :uid
  validates :name, presence: true
end
