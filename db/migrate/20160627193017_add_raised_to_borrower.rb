class AddRaisedToBorrower < ActiveRecord::Migration
  def change
  	add_column :borrowers, :need, :integer
  end
end
