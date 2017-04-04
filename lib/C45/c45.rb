require "csv"

def read_file
  CSV.open("public/DaTa_Mau.csv", headers: true, header_converters: :symbol).map{|row| row.to_h}
end

class GainRatio
  attr_accessor :value, :attribute
  def initialize value, attribute
    @value = value
    @attribute = attribute
  end
end

class Node
  attr_accessor :childrens, :name, :value, :foods, :is_match

  def initialize name = nil, foods = [], value = nil, is_match = true
    @name = name
    @foods = foods
    @value = value
    @is_match = is_match
    @childrens = []
  end

  def add_childrens chil
    @childrens.push *chil
  end
end

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

class C45
  attr_accessor :data, :root, :arr_gain_ratios, :attributes

  def initialize
    @data = CSV.open("public/DaTa_Mau.csv", headers: true, header_converters: :symbol).map{|row| row.to_h}
    @arr_gain_ratios = Array.new
    @gioi_tinhs = Attribute.new "gioitinh", @data.map{|food| food[:gioitinh]}.uniq
    @tinh_trangs = Attribute.new "tinhtrang", @data.map{|food| food[:tinhtrang]}.uniq
    @xu_huongs = Attribute.new "xuhuong", @data.map{|food| food[:xuhuong]}.uniq
    @attributes = [@gioi_tinhs, @tinh_trangs, @xu_huongs]
    gain_ratio
    attribute= arr_gain_ratios[0].attribute
    @root = Node.new attribute.name, @data
    recursive_tree @root, 0
  end

  def calc_entropy attribute
    entropy = 0.0
    s = @data.count.to_f
    attribute.values.each do |value|
      c = @data.select{|food| food[:tinhhieuqua] == "Có" && food[attribute.name.to_sym] == value}.count.to_f
      k = @data.select{|food| food[:tinhhieuqua] == "không" && food[attribute.name.to_sym] == value}.count.to_f
      instance = ((c+k)/s) * (((-c/(k+c)) * Math.log((c/(k+c)),2))-(((-k/(k+c)) * Math.log((k/(k+c)),2))))
      entropy += instance unless instance.is_a?(Float) && instance.nan?
    end
    entropy
  end

  def gain attribute
    tinh_IS - calc_entropy(attribute)
  end

  def split_info attribute
    split = 0.0
    s = @data.count.to_f
    attribute.values.each do |value|
      c = @data.select{|food| food[:tinhhieuqua] == "Có" && food[attribute.name.to_sym] == value}.count.to_f
      k = @data.select{|food| food[:tinhhieuqua] == "không" && food[attribute.name.to_sym] == value}.count.to_f
      instance = (-(c + k) / s) * (((k + c) / s) * Math.log(((k + c) / s), 2)) || 0
      split += instance unless instance.is_a?(Float) && instance.nan?
    end
    split
  end

  def gain_ration attribute
    gain(attribute) - split_info(attribute)
  end

  def gain_ratio
    @attributes.each do |attribute|
      @arr_gain_ratios.push GainRatio.new(gain_ration(attribute), attribute)
    end
    @arr_gain_ratios.sort_by {|gain| gain.value}
  end



  def recursive_tree node, level
    return if level == @arr_gain_ratios.size
    gain_ratio = @arr_gain_ratios[level]
    attribute = gain_ratio.attribute
    attribute.values.each do |value|
      match_foods = node.foods.select {|food| food[:tinhhieuqua] == "Có" && food[attribute.name.to_sym] == value}
      if match_foods.any?
        m = Node.new( attribute.name, match_foods, value, true)
        node.add_childrens m
        recursive_tree m, level + 1
      end
      not_match_foods = node.foods.select {|food| food[:tinhhieuqua] == "không" && food[attribute.name.to_sym] == value}
      if not_match_foods.any?
        nm = Node.new(attribute.name, not_match_foods, value, true)
        node.add_childrens nm
        recursive_tree nm, level + 1
      end
    end
  end

  def make_node name, value, foods
  end

  private
  def count_total_positives samples
    samples.select {|t| t[:tinhhieuqua] == "Có"}.count
  end

  def tinh_IS
    s = @data.count.to_f
    c = @data.select {|t| t[:tinhhieuqua] == "Có"}&.count.to_f
    k = s - c
    (-(k/c) * Math.log(k / s,2) - ((c/s) * Math.log(c/s, 2)))
  end
end
