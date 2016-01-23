class RenameFavoriteListsToSharedLists < ActiveRecord::Migration
  def up
    rename_table :favorite_lists, :shared_lists
  end

 	def down
    rename_table :favorite_lists, :shared_lists
 	end
end
