# frozen_string_literal: true

require 'rails_helper

descrive : 投稿のテスト
  let!(:goal){ create(;goal, title:'hoge', content: 'content', deadline'')}
  describe：トップ画面(top_path)のテスト
    before：トップ画面への遷移
    context：表示の確認
      it：トップ画面(top_path)に「ここはTopページです」が表示されているか
        テストコード
      it：top_pathが"/top"であるか
        テストコード
