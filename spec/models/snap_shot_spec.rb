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

require 'spec_helper'

describe SnapShot do
  pending "add some examples to (or delete) #{__FILE__}"
end
