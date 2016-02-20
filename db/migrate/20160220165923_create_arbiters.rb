class CreateArbiters < ActiveRecord::Migration
  def change
    create_table :arbiters do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
