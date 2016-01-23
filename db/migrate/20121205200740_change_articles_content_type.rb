class ChangeArticlesContentType < ActiveRecord::Migration
  def change
    change_column :articles, :content, :text, :limit => nil
  end
end
