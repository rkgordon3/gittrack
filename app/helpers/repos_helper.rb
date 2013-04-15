module ReposHelper
	def repo_accordian_id(repo)
		"repo_accordian_#{repo.id}"
	end

	def repo_committer_accordian(repo)
		"repo_committer_accordian_#{repo.id}"
	end


	def snapshot_accordian_id(snap)
		"snapshot_accoridian_#{snap.id}"
	end

	def committer_accordian_id(committer) 
		"committer_accordian_#{committer.id}"
	end
end
