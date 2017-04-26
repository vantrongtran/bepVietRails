class Hashtag < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  scope :search, -> key {where("name like ?", "%#{key}%") if key.present?}
end
