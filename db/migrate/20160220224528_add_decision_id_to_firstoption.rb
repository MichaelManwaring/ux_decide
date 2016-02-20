class AddDecisionIdToFirstoption < ActiveRecord::Migration
  def change
    add_column :firstoptions, :decision_id, :integer
  end
end
