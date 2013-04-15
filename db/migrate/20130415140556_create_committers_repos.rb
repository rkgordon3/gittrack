class CreateCommittersRepos < ActiveRecord::Migration
  def change
    create_table :committers_repos do |t|
      t.integer :repo_id
      t.integer :committer_id

      t.timestamps
    end
  end
end
