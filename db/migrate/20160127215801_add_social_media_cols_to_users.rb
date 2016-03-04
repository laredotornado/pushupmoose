class AddSocialMediaColsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :image_url, :string
    add_column :users, :url, :string
  end
end
