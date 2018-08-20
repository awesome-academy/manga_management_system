class ChangeColumnComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :manga_id
    add_reference :comments, :chapter
  end
end
