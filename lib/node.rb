class Node
  attr_accessor :children, :name, :value, :foods, :is_match

  def initialize name = nil, foods = [], value = nil, is_match = true
    @name = name
    @foods = foods
    @value = value
    @is_match = is_match
    @children = []
  end

  def add_children chil
    @children.push *chil
  end
end
