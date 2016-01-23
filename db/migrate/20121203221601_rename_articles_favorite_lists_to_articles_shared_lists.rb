class RenameArticlesFavoriteListsToArticlesSharedLists < ActiveRecord::Migration
  def up
  	rename_table :articles_favorite_lists, :articles_shared_lists
  	rename_column :articles_shared_lists, :favorite_list_id, :shared_list_id
  end

  def down
  	rename_column :articles_shared_lists, :shared_list_id, :favorite_list_id
  	rename_table :articles_shared_lists, :articles_favorite_lists
  end
end
