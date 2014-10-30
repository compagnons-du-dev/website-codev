class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :name
      t.string :title, default: ''
      t.string :link
      t.text :value, default: ''

      t.string :partial
      t.references :page, index: true
      t.references :article, index: true
      t.integer :position
      t.boolean :fixed, default: false

      t.attachment :image
      t.attachment :file


      t.timestamps
    end
  end
end
