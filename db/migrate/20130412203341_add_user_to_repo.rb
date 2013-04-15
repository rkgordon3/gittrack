class AddUserToRepo < ActiveRecord::Migration
  def change
    add_column :repos, :user, :string
  end
end
