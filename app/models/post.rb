class Post < ApplicationRecord
  validates :game_name, {presence: true}
  validates :thread_name, {presence: true}
end
