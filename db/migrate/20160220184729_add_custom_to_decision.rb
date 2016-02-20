class AddCustomToDecision < ActiveRecord::Migration
  def change
    add_column :decisions, :custom, :boolean
  end
end
