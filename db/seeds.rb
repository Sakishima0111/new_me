Admin.find_or_create_by(
   email: 'admin@admin',
   password: 'testtest'
)
User.find_or_create_by(
   email: 'cat@cat',
   nickname: 'ネコ',
   introduction: 'テストユーザー1',
   password: "testtest"
)
User.find_or_create_by(
   email: 'dog@dog',
   nickname: 'いぬ',
   introduction: 'テストユーザー2',
   password: "testtest"
)
User.find_or_create_by(
   email: 'momo@momo',
   nickname: 'ももたろう',
   introduction: 'テストユーザー3',
   password: "testtest"
)
User.find_or_create_by(
   email: 'ura@ura',
   nickname: 'うらしまたろう',
   introduction: 'テストユーザー4',
   password: "testtest"
)
User.find_or_create_by(
   email: 'kin@kin',
   nickname: 'きんたろう',
   introduction: 'テストユーザー5',
   password: "testtest"
)

Category.find_or_create_by([
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

