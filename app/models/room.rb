class Room < ApplicationRecord
  has_many :room_users
  haz_many :users, through: room_users
end
