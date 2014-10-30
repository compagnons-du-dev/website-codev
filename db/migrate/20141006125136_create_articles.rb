class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.string :slug
      t.attachment :image
      t.boolean :publish, default: false

      t.timestamps
    end

    add_index :articles, :slug, unique: true
  end
end
