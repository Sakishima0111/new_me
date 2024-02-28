class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :introduction
      t.string :image, null: false
      t.integer :owner_id, null: false
      t.timestamps
    end
  end
end
