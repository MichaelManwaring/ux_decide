class CleanUpVotes < ActiveRecord::Migration
  def change
  	remove_column :votes, :option_id
  	add_column :votes, :firstoption_id, :integer
  	add_column :votes, :secondoption_id, :integer
  end
end
