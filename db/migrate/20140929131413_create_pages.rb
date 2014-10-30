class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.references :category, index: true
      t.boolean :publish, default: false
      t.string :slug

      t.timestamps
    end
    add_index :pages, :slug, unique: true
  end
end
