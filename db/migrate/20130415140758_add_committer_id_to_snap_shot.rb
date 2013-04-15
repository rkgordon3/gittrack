class AddCommitterIdToSnapShot < ActiveRecord::Migration
  def change
    add_column :snap_shots, :committer_id, :integer
  end
end
