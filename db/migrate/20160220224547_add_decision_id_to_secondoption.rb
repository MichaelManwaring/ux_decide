class AddDecisionIdToSecondoption < ActiveRecord::Migration
  def change
    add_column :secondoptions, :decision_id, :integer
  end
end
