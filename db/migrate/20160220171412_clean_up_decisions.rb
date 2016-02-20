class CleanUpDecisions < ActiveRecord::Migration
  def change
  	remove_column :decisions, :option_a 
  	remove_column :decisions, :option_b
  	remove_column :decisions, :dec_type
  	remove_column :decisions, :a_count
  	remove_column :decisions, :b_count
  	remove_column :decisions, :vote_choice
  	remove_column :decisions, :user_id
  	add_column :decisions, :arbiter_id, :integer
  	add_column :decisions, :type_id, :integer
  end
end
