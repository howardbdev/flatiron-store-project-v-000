class AddTitleToItems < ActiveRecord::Migration
  def change
    add_column :items, :title, :string
    remove_column :items, :name
  end
end
