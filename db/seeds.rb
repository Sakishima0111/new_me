
puts "seedの実行を開始"

Admin.find_or_create_by!(email: 'admin@admin') do |admin|
  admin.password = ENV["SECRET_KEY"]
end

10.times do |n|
  User.find_or_create_by!(email: "test#{n + 1}@hoge") do |user|
    user.nickname = "testuser#{n + 1}"
    user.introduction = "テストユーザーです。"
    user.password = "testuser#{n + 1}"
  end
end
# 10.times do |n|
#     password = "testuser#{n + 1}"
#     nickname = "testuser#{n + 1}"
#     User.create(
#       email: "test#{n + 1}@hoge",
#       nickname: nickname,
#       introduction: "テストユーザーです。",
#       encrypted_password: password
#     )
# end
category_data = [
  { name: '勉強・資格' },
  { name: '筋トレ・ダイエット' },
  { name: '生活' },
  { name: '仕事' },
  { name: '美容' },
  { name: '経済・貯金' },
  { name: '交流' },
  { name: '趣味' },
  { name: '旅行' },
  { name: '健康' },
  { name: '自己成長' },
  { name: 'アート' },
  { name: '技術' },
  { name: '環境' },
  { name: 'その他' }
]

category_data.each do |data|
  Category.find_or_create_by!(data)
end

User.all.each do |user|
  10.times do |n|
    Goal.find_or_create_by!(title: "筋トレを毎日する_#{n}") do |goal|
      goal.content = "家で毎日30分筋トレをする"
      goal.user = user
      goal.category_id = rand(1..10)
      goal.deadline = Random.rand(DateTime.new(2024, 5, 1) ... DateTime.new(2024, 7, 1))
      goal.reward = "チートデイをする！"
    end
  end
end

puts "seedの実行が完了しました"

