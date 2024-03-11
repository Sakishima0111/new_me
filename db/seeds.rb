Admin.create!(
   email: 'admin@admin',
   password: 'testtest'
)
User.create!(
   email: 'cat@cat',
   name: 'ネコ',
   introduction: 'にゃー',
)
User.create!(
   email: 'dog@dog',
   name: 'いぬ',
   introduction: 'ワン！',
)


Category.create([
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
  { name: 'その他' },
])