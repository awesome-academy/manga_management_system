class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.references :chapter, foreign_key: true
      t.text :image

      t.timestamps
    end
  end
end
