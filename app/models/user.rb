class User < ApplicationRecord

  paginates_per 12

  attr_accessor :current_password

  validates_presence_of   :email, if: :email_required?
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  validates_format_of     :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?
  validate :validate_birthday, on: [:create, :update], unless: :valid_birthday?
  validates_length_of       :password, within: Devise.password_length, allow_blank: true

  after_destroy :send_mail_delete

  def password_required?
    return false if email.blank?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    true
  end

  ratyrate_rater

  devise :omniauthable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable

  has_many :identities, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :pots
  has_many :active_relationships,
    class_name: Relationship.name, foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :active_relationships,
    source: :followed
  has_many :passive_relationships,
    class_name: Relationship.name, foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships,
    source: :follower
  has_many :conditions
  has_many :comments, dependent: :destroy
  has_many :favorite_rates, -> {where stars: 5}, foreign_key: :rater_id, class_name: Rate.name
  has_many :favorite_foods, through: :favorite_rates, source: :rateable, source_type: Food.name
  has_many :user_conditions, class_name:Condition::UserCondition.name, foreign_key: :target_id
  has_many :likes, dependent: :destroy
  has_many :liked_tips, through: :likes, source_type: Post::Tip.name, source: :target
  has_many :liked_posts, through: :likes, source_type: Post::UserPost.name, source: :target
  has_many :liked_activities, through: :likes, source_type: Activity.name, source: :target
  has_many :liked_comments, through: :likes, source_type: Comment.name, source: :target
  has_many :user_posts, class_name: Post::UserPost.name, foreign_key: :target_id, dependent: :destroy

  accepts_nested_attributes_for :user_conditions,
    reject_if: ->attributes{attributes[:condition_detail_id].blank?}, allow_destroy: true

  mount_uploader :avatar, PictureUploader

  scope :name_like, -> keyword { where("name LIKE ?", "%#{keyword}%").or(where email: keyword) if keyword.present?}

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def twitter
    identities.where( :provider => "twitter" ).first
  end

  def twitter_client
    @twitter_client ||= Twitter.client( access_token: twitter.accesstoken )
  end

  def facebook
    identities.where( :provider => "facebook" ).first
  end

  def facebook_client
    @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
  end

  def instagram
    identities.where( :provider => "instagram" ).first
  end

  def instagram_client
    @instagram_client ||= Instagram.client( access_token: instagram.accesstoken )
  end

  def google_oauth2
    identities.where( :provider => "google_oauth2" ).first
  end

  def liked? obj
    case obj.class.name
    when Post::UserPost.name
      self.liked_posts.include? obj
    when Activity.name
      self.liked_activities.include? obj
    when Comment.name
      self.liked_comments.include? obj
    when Post::Tip.name
      self.liked_tips.include? obj
    else
      false
    end
  end

  def like_of obj
    self.likes.find_by target_id: obj.id, target_type: obj.class.name
  end

  def validate_birthday
    errors.add :birthday, I18n.t(".birthday")
  end

  def valid_birthday?
    birthday.nil? || birthday <= Time.zone.now
  end

  def send_mail_delete
    UserNotifierMailer.send_email_delete(self).deliver_now
  end
end
