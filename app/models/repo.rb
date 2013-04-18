# == Schema Information
#
# Table name: repos
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  last_track_date :datetime
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  user            :string(255)
#

class Repo < ActiveRecord::Base

  	attr_accessible :last_track_date, :name, :user
  	has_and_belongs_to_many :committers
  	has_many :snap_shots
    def most_recent_snapshot
    	snap_shots.where("repo_id = ?", self.id).order("created_at DESC").first 
    end

    def snapshots_for(committer) 
    	SnapShot.where("committer_id= ? and repo_id = ?", committer.id, self.id).order("created_at DESC")
    end

    def summary_for(committer)
        snapshots = snapshots_for(committer)
        total_commits = snapshots.inject(0) { |v, s| v + s.commit_count }
    end


end
