class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :type_id
      t.integer :arbiter_id
      t.integer :a_score
      t.integer :b_score

      t.timestamps null: false
    end
  end
end
