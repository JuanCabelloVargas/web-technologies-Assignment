class CreateChallenges < ActiveRecord::Migration[8.0]
  def change
    create_table :challenges do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :visibility, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
