class Category < ApplicationRecord
  has_many :foods

  before_destroy :delete_children_category

  validates :name, presence: true

  default_scope {where.not(id: 1).order(left: :asc)}

  class << self
    def add name, parent_right
      ActiveRecord::Base.transaction do
        Category.where("`categories`.`right` >= ?", parent_right).update_all "`categories`.`right` = `categories`.`right` + 2"
        Category.where("`categories`.`left` > ?", parent_right).update_all "`categories`.`left` = `categories`.`left` + 2"
        Category.create name: name, left: parent_right,right: parent_right + 1
      end
    end
  end

  def children
    Category.where left: self.left..self.right
  end

  def leaf_node?
    right - left == 1
  end

  private
  def delete_children_category
    width = self.right - self.left + 1
    ActiveRecord::Base.transaction do
      self.children.delete_all
      Category.where("`categories`.`right` > ?", self.right).update_all("`categories`.`right` = `categories`.`right` - #{width}")
      Category.where("`categories`.`left` > ?", self.right).update_all("`categories`.`left` = `categories`.`left` - #{width}")
    end
  end
end
