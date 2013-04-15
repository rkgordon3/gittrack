class Committer < ActiveRecord::Base
  attr_accessible :email
  has_and_belongs_to_many :repos
end
