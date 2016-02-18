class CreateDecisions < ActiveRecord::Migration
  def change
    create_table :decisions do |t|
      t.integer :dec_type
      t.integer :app_choice
      t.integer :user_choice
      t.text :description
      t.string :option_a
      t.string :option_b
      t.integer :a_count
      t.integer :b_count
      t.integer :vote_choice
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
