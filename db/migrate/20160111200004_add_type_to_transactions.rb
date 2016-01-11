class AddTypeToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :outgoing, :boolean
  end
end
