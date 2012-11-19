class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :dispid
      t.references :parent

      t.timestamps
    end
    add_index :chapters, :parent_id
  end
end
