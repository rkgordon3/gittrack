# == Schema Information
#
# Table name: snap_shots
#
#  id              :integer         not null, primary key
#  commiter_email  :string(255)
#  commit_count    :integer
#  files_touched   :integer
#  addition        :integer
#  deletions       :integer
#  loc_touched     :integer
#  tags            :string(255)
#  max_commit_size :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  repo_id         :integer
#

class SnapShot < ActiveRecord::Base
  attr_accessible :repo_id, :committer_id, :additions, :commit_count, :committer_email, :deletions, :files_touched, :loc_touched, :max_commit_size, :tags
  belongs_to :repo
end
