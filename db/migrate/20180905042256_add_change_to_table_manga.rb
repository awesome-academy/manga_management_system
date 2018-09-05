class AddChangeToTableManga < ActiveRecord::Migration[5.2]
  def change
    change_column :mangas, :number_of_read, :integer, :default => 0
  end
end
