class AddRepoIdToSnapShot < ActiveRecord::Migration
  def change
    add_column :snap_shots, :repo_id, :integer
  end
end
