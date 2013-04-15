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

require 'spec_helper'

describe Repo do
  pending "add some examples to (or delete) #{__FILE__}"
end
