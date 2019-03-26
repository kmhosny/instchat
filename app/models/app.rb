class App < ApplicationRecord
  has_secure_token :id
  validates :name, presence: true
  has_many :chats
end
