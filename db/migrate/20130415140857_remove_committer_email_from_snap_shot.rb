class RemoveCommitterEmailFromSnapShot < ActiveRecord::Migration
  def up
   remove_column :snap_shots, :committer_email
  end

  def down
  end
end
