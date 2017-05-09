class C45
  attr_accessor :data, :root, :arr_gain_ratios, :attributes

  def initialize data, conditions
    @data = data
    if @data.size > 0
      @s = @data.size.to_f
      @arr_gain_ratios = Array.new
      @attributes = conditions
      gain_ratio
      attribute= arr_gain_ratios[0].attribute
      @root = Node.new attribute, @data, @arr_gain_ratios[0].value, "True/Flase"
      @root = recursive_tree @root, 0
    end
  end

  def calc_entropy attribute
    entropy = 0.0
    attribute.condition_details.each do |condition_details|
      c = condition_details.food_target_conditions.is_match(true).size.to_f
      k = condition_details.food_target_conditions.is_match(false).size.to_f
      instance = ((c+k)/@s) * (((-c/(k+c)) * Math.log((c/(k+c)),2))-(((-k/(k+c)) * Math.log((k/(k+c)),2))))
      entropy += instance unless instance.is_a?(Float) && instance.nan?
    end
    entropy
  end

  def gain attribute
    tinh_IS(attribute) - calc_entropy(attribute)
  end

  def split_info attribute
    split = 0.0
    attribute.condition_details.each do |condition_details|
      c = condition_details.food_target_conditions.is_match(true).size.to_f
      k = condition_details.food_target_conditions.is_match(false).size.to_f
      instance = (-(c + k) / @s) * (((k + c) / @s) * Math.log(((k + c) / @s), 2))
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
    @arr_gain_ratios = @arr_gain_ratios.sort_by {|gain| gain.value}.reverse
  end

  def to_node_food node
    children = node.children
    text = {
      name: node.name,
      title: "Match records: #{node.food_target_conditions&.count || 0}",
      desc: "Match: #{node.is_match}"
    }
    text[:desc] = "Gain Ratio: #{node.value}" if node.value != 0
    json = {text: text}
    json[:children] = children.map {|child| to_node_food child} if(children.any?)
    case
    when node.value != 0
      json[:HTMLclass] = "light-gray"
    when node.is_match
      json[:HTMLclass] = "match"
    when !node.is_match
      json[:HTMLclass] = "not-match"
    end
    json
  end

  def to_json
    to_node_food @root
  end

  def recursive_tree node, level
    return if level == @arr_gain_ratios.size
    gain_ratio = @arr_gain_ratios[level]
    attribute = gain_ratio.attribute
    if level == 0
      new_root = node
    else
      new_root = Node.new attribute, node.food_target_conditions, gain_ratio.value, "True/Flase"
    end
    attribute.condition_details.each do |value|
      match_foods = FoodTargetCondition.in(node.food_target_conditions.map(&:id)).match_condition value.id
      if match_foods.any?
        m = Node.new( value, match_foods, 0, true)
        recursive_tree m, level + 1
        new_root.add_children m if m
      end
      not_match_foods = FoodTargetCondition.in(node.food_target_conditions.map(&:id)).not_match_condition value.id
      if not_match_foods.any?
        nm = Node.new(value, not_match_foods, 0, false)
        recursive_tree nm, level + 1
        new_root.add_children nm if nm
      end
    end
    if level > 0 && new_root.children.any?
      node.add_children new_root
    end
    return node
  end

  def make_node name, value, foods
  end

  private
  def tinh_IS attribute
    c = attribute.food_target_conditions.is_match(true).size.to_f
    c = @s - @s/10 if c = @s
    k = @s - c
    @tinh_IS = (-(k/c) * Math.log(k / @s,2) - ((c/@s) * Math.log(c/@s, 2)))
  end
end
