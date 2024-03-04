class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :description
      t.string :image
      t.integer :owner_id
      t.timestamps
    end
  end
end
