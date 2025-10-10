class CreateBadges < ActiveRecord::Migration[8.0]
  def change
    create_table :badges do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.text :icon_url

      t.timestamps
    end
  end
end
