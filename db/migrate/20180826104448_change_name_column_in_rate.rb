class ChangeNameColumnInRate < ActiveRecord::Migration[5.2]
  def change
    rename_column :rates, :number_of_rates, :rating
  end
end
