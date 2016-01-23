class CreateNewsLists < ActiveRecord::Migration
  def change
    create_table :news_lists do |t|
    	t.boolean :is_private, default: false
    	t.integer :user_id
      t.timestamps
    end
  end
end
