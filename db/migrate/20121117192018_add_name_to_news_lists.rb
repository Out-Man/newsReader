class AddNameToNewsLists < ActiveRecord::Migration
  def change
  	add_column :news_lists, :name, :string
  end
end
