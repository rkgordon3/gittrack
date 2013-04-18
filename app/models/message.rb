class Message < ActiveRecord::Base
  attr_accessible :snap_shot_id, :text, :sha
end
