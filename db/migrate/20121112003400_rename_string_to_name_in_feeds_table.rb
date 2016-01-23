class RenameStringToNameInFeedsTable < ActiveRecord::Migration
  def change
  	rename_column :feeds, :string, :name
  end
end
