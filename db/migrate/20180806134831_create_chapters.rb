class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.references :manga
      t.string :name
      t.text :images
      t.text :content

      t.timestamps
    end
  end
end
