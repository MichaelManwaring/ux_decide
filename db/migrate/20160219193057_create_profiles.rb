class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :this
      t.integer :that
      t.integer :cheap
      t.integer :expensive
      t.integer :healthy
      t.integer :indulge
      t.integer :easy
      t.integer :hard
      t.integer :safe
      t.integer :risky
      t.integer :adventure
      t.integer :relax

      t.timestamps null: false
    end
  end
end
