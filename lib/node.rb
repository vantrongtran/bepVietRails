class Node
  attr_accessor :children, :condition, :value, :food_target_conditions, :is_match

  def initialize condition = nil, foods = [], value = nil, is_match = true
    @condition = condition
    @food_target_conditions = foods
    @value = value
    @is_match = is_match
    @children = []
  end

  def name
    @condition.name
  end

  def add_children chil
    @children.push *chil
  end
end
