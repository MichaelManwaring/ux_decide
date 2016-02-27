class AddVotingOpenToDecisions < ActiveRecord::Migration
  def change
    add_column :decisions, :voting_open, :boolean
    remove_column :decisions, :custom, :boolean
  end
end
