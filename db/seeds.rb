
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


goals = [
   {title: "筋トレを毎日する", content: "家で毎日30分筋トレをする", category: 2 , reward: "新しいプロテイン購入"},
   {title: "英検2級を取得する", content: "単語を1日30個ずつ覚える", category: 1, reward: "漫画を買う" },
   {title: "家を綺麗な状態に保つ", content: "毎晩散らかしたものをもとに戻す", category: 3, reward: "自分をほめる" },
   {title: "課長になる", content: "資格取得をする", category: 4, reward: "飲み会に行く"},
   {title: "肌をきれいにする", content: "ニキビ治療、生活習慣の改善をする", category: 5, reward: "いろんなメイクに挑戦する"},
   {title: "貯金300万を目指す", content: "毎日お弁当を作って、飲み会は週１にする", category: 6, reward: "海外旅行に行く"},
   {title: "友達を10人作る", content: "1日1人話しかけてみる", category: 7, reward: "友達100人を目指す"},
   {title: "吉祥寺周辺のカフェを知り尽くす", content: "土日にカフェめぐりをする", category: 8, reward: "他の地域開拓"},
   {title: "韓国に行く準備をする", content: "韓国語の勉強を毎日する", category: 9, reward: "広蔵市場で食べ歩き"},
   {title: "血圧が高くならないようにする", content: "怒らない", category: 10, reward: "将来も安心"},
   {title: "知識のある大人になる", content: "毎日本を読む", category: 11, reward: "自己満足できる"},
   {title: "個展を開く", content: "作品を最低でも20個作る", category: 12, reward: "パフェを食べる"},
   {title: "地球温暖化を阻止する", content: "ウシのゲップによるメタンガスを有効活用する", category: 14, reward: "そういえば今プチ氷河期入ってた"},
   {title: "Javaをマスターする", content: "1日3時間勉強する", category: 13, reward: "サウナに行く"},
   {title: "12時に寝る", content: "家に帰ったら先にお風呂を済ませる", category: 15, reward: "健康体になる"},
]

goals.each do |goal|
  # 一度目標をタイトルで検索
  goal_data = Goal.find_by(title: goal[:title])
  # 該当目標がなければ、createする
  if goal_data.nil?
    Goal.create(
      content: goal[:content],
      user_id: rand(1..10),
      category_id: goal[:category],
      deadline: Random.rand(DateTime.new(2024, 5, 1) ... DateTime.new(2025, 1, 1)),
      reward: goal[:reward]
    )
  end
end

User.all.each do |user|
  10.times do |n|
    Goal.find_or_create_by!(title: "筋トレを毎日する_#{n}") do |goal|
      goal.content = "家で毎日30分筋トレをする"
      goal.user = user
      goal.category_id = rand(1..15)
      goal.deadline = Random.rand(DateTime.new(2024, 5, 1) ... DateTime.new(2024, 7, 1))
      goal.reward = "チートデイをする！"
    end
  end
end

puts "seedの実行が完了しました"

