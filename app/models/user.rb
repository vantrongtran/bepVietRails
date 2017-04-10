class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :activites
  has_many :likes
  has_many :pots
  has_many :relationships
  has_many :conditions
  has_many :follower
  has_many :followed
end
