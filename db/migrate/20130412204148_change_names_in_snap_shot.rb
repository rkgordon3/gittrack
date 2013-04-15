class ChangeNamesInSnapShot < ActiveRecord::Migration
  def up
   rename_column :snap_shots, :commiter_email, :committer_email
   rename_column :snap_shots, :addition, :additions
  end

  def down
  end
end
