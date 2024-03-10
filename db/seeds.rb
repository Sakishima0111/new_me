Admin.create!(
   email: 'admin@admin',
   password: 'testtest'
)

@names = ['勉強・資格', '筋トレ・ダイエット', '生活', '仕事', '美容', '経済・貯金', '交流', '趣味', '旅行', '健康', '自己成長', 'アート', '技術', '環境', 'その他']

@names.each do |name|
  Category.create!(name: name)
end