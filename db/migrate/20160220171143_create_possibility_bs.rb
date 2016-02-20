class CreatePossibilityBs < ActiveRecord::Migration
  def change
    create_table :possibility_bs do |t|
      t.integer :decision_id
      t.integer :option_id

      t.timestamps null: false
    end
  end
end
