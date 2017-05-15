puts "---------------------"
puts "Create ingredients"
20.times { |i| Ingredient.create! name: Faker::Food.ingredient, inscription: "g" }

puts "---------------------"
puts "Create base Category"
c = Category.create! name: "BASE CATEGORY", left: 1, right: 2, level: 0
  5.times do |n|
    s = Category.add! Faker::Name.name, c.right, c.level
      5.times do
        Category.add! Faker::Name.name, s.right, s.level
        s.reload
      end
    c.reload
  end

puts "---------------------"
puts "Create Condition"
c = Condition.create! name: "Illness"
5.times do |n|
  c.condition_details.create! value: "Bệnh #{ n+ 1}"
end
c1 = Condition.create! name: "Gender"
c1.condition_details.create! value: "Female"
c1.condition_details.create! value: "Male"
c2 = Condition.create! name: "Tendency"
c2.condition_details.create! value: "Up"
c2.condition_details.create! value: "Down"

puts "---------------------"
puts "Create food"
50.times do |n|
  food = Food.create! name: Faker::Name.name, cooking_method: Faker::Lorem.paragraphs,
    calorie: Faker::Number.decimal(2, 3)
  rand(2..7).times do |t|
    food_target_condition = food.food_target_conditions.create is_match: rand(0..1)
      conditions = []
    Condition.all.each do |condition|
      Condition::FoodCondition.create! target_id: food_target_condition.id,  is_match: rand(0..1),
        condition_detail_id: condition.condition_details.sample.id
    end
  end
  used = []
  rand(6..10).times do |i|
      used.push *(ingredient = ([*1..20] - used).sample)
      food.food_ingredients.create! ingredient_id: ingredient, value: Faker::Number.decimal(2, 3)
  end
end
puts "---------------------"
puts "Create User"
user = User.create!(
  name: "Tiến đẹp trai hào hoa tiêu sái",
  email: "manager@gmail.com",
  birthday: 15.day.ago,
  password: "12312311",
)
30.times do |n|
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    birthday: 15.day.ago,
    password: "12312311",
  )
end

User.create name: "user", email: "user@gmail.com", password: "12312311"

users = User.first(20)
puts "---------------------"
puts "Create post"
50.times do |n|
  post = Post::Tip.create! title: Faker::Lorem.sentence, content: Faker::Lorem.paragraphs, target_id: rand(2..6)
end
users.each do |user|
  rand(1..5).times do
    user.user_posts.create!(
      title: Faker::Lorem.sentence, content: Faker::Lorem.paragraphs
    )
  end
end

puts "Fake Follow"
users.each do |user|
  ((user.id + 1)..30).each do |i|
    user.follow User.find(i)
  end
end
