class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.datetime :deadline, null: false
      t.string :reward, null: false
      t.integer :status, null: false, default: 1
      t.integer :category_id
      t.text :lookback
      t.timestamps
    end
  end
end
