class AddAuthorAndContentToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :content, :string
  	add_column :articles, :author, :string
  	remove_column :articles, :name
  	add_column :articles, :title, :string
  end
end
