class CreateSnapShots < ActiveRecord::Migration
  def change
    create_table :snap_shots do |t|
      t.string :commiter_email
      t.integer :commit_count
      t.integer :files_touched
      t.integer :addition
      t.integer :deletions
      t.integer :loc_touched
      t.string :tags
      t.integer :max_commit_size

      t.timestamps
    end
  end
end
