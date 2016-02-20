class CreateFirstoptions < ActiveRecord::Migration
  def change
    create_table :firstoptions do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
