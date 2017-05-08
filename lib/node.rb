class Node
  attr_accessor :children, :name, :value, :food_target_conditions, :is_match

  def initialize name = nil, foods = [], value = nil, is_match = true
    @name = name
    @food_target_conditions = foods
    @value = value
    @is_match = is_match
    @children = []
  end

  def add_children chil
    @children.push *chil
  end
end
