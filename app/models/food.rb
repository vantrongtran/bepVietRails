class Food < ApplicationRecord

  has_many :food_ingredients, dependent: :destroy
  has_many :ingredients, through: :food_ingredients
  has_many :food_target_conditions
  has_many :food_conditions, through: :food_target_conditions, dependent: :destroy
  has_many :condition_details, through: :food_conditions
  has_many :conditions, through: :condition_details
  has_many :food_hashtags, foreign_key: :target_id, class_name: Hashtag::FoodHashtag.name
  has_many :hashtags, through: :food_hashtags
  has_many :comments, as: :target

  validates :name, :cooking_method, :calorie, presence: true

  accepts_nested_attributes_for :food_ingredients,
    reject_if: ->attributes{attributes[:value].blank?}, allow_destroy: true
  accepts_nested_attributes_for :food_hashtags, allow_destroy: true
  accepts_nested_attributes_for :hashtags,
    reject_if: ->attributes{attributes[:name].blank?}
  accepts_nested_attributes_for :food_target_conditions, allow_destroy: true
  accepts_nested_attributes_for :food_conditions,
    reject_if: ->attributes{attributes[:condition_detail_id].blank?}, allow_destroy: true

  mount_uploader :image, PictureUploader

  scope :name_like, -> keyword {where("name LIKE ?", "%#{keyword}%") if keyword.present?}

  ratyrate_rateable

  scope :search_by_name, ->keyword { where "name LIKE %?%", keyword }
  # scope :search_by_name, ->keyword { where "name LIKE ?", "%#{keyword}%" }

  class << self
    def sugget target_conditions
     conditions = target_conditions.inject([]){|result, tc| result << c = tc.condition unless result.include? c}
     c45 = C45.new FoodTargetCondition.all, conditions
     root = c45.root
     while conditions.count > 0

      end
    end

    def get_node root, conditions

    end
  end
end
