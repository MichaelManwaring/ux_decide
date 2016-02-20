class CreateSecondoptions < ActiveRecord::Migration
  def change
    create_table :secondoptions do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
