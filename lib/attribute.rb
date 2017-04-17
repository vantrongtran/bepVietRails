class Attribute
  attr_accessor :name, :values
  def initialize name, values
    @name = name || ""
    @values = values || Array.new
  end

  def isValidValue value
    return indexValue(value)
  end

  def indexValue value
    @values.include? value
  end

  def to_s
    name
  end
end
