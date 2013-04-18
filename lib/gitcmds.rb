require 'github_api'
require 'trollop'

require File.join(File.dirname(__FILE__), "..", "config", "boot")
require File.join(File.dirname(__FILE__), "..", "config", "environment")

class SnapShotDesc
	attr_accessor 	:files_touched 
	attr_accessor 	:max_commit_size
	attr_accessor 	:commit_count
	attr_accessor 	:deletes
	attr_accessor 	:additions
	attr_accessor 	:loc_touched 
	attr_accessor	:tags
	attr_accessor	:committer_email
	attr_accessor	:messages

	def initialize
		@files_touched = 0
		@max_commit_size = -1
		@commit_count = 0.0
		@deletes = 0
		@additions = 0
		@loc_touched = 0
		@tags = {}
		@messages = []
	end

	def self.extract_tags(message)
		message.downcase.scan(/user\s*stor(y|ies):?\s*(\d*)/).flatten
	end

end

def persist(user, repo, snapshot, email)
	repo_model = Repo.find_by_name(repo)|| Repo.create!(name: repo, user: user)
	count = snapshot.commit_count
	committer = Committer.find_by_email(email)
	puts "in persist Committer #{committer}"
	if committer.nil?
		puts 'create new committer'
		committer = Committer.create!(email: email)
				puts "create new committer repo #{committer.id} #{repo_model.id}"
		CommittersRepos.create!(committer_id: committer.id, repo_id: repo_model.id)
	end
	ss = SnapShot.create!(repo_id: repo_model.id,
				 committer_id: committer.id,
				 commit_count: count,
				 files_touched: snapshot.files_touched/count,
				 additions: snapshot.additions/count,
				 deletions: snapshot.deletes/count,
				 loc_touched: snapshot.loc_touched/count,
				 max_commit_size: snapshot.max_commit_size
		) 
	snapshot.messages.map { |m|  
		puts "saving message #{m} with snap shot #{ss.id}"
		Message.create!(snap_shot_id: ss.id, sha: m[0], text: m[1])
	}
end

opts = Trollop::options  do
   banner <<-EOS
     Usage 'ruby gitapi.rb [-u <github-user-name>] [-r <repo>] 
              [-s <since>] 
     
    Print statistics for github activity for a given repository for last <since> days.

   EOS
       opt :user, "github user name", :type=>:string
       opt :repo, "repository name", :type=> :string
       opt :since, "Number of days of history to get", :default => "2"
       opt :since_last, "Use db timestamp for 'since' date"
       opt :no_persist, "Do not persist commit data"
       opt :track, "Log tracking timestamp"
   end


def fetch_commits(user, repo, since, persist = true )
	puts "Generate stats for #{user} @ #{repo} since #{since}"
	github = Github.new  login: 'rgordon@smumn.edu', password: 'nd1r1sh80'
	commits_since = github.repos.commits.list user: user, repo: repo, since: since
	if commits_since.size > 0
		most_recent_commit = commits_since[0]
		commit_resp = github.repos.commits.get user: user, repo: repo, sha: most_recent_commit.sha
		snapshots = {} # a map of maps keyed by committer

		commits_since.each do |c| 

		    #puts "date convert #{DateTime.strptime(c.commit.author.date).iso8601} "
		    commit_resp = github.repos.commits.get user: user, repo: repo, sha: c.sha
		    committer = commit_resp.commit.committer.email
		    snapshot = snapshots[committer] || snapshots[committer] = SnapShotDesc.new
		 puts "commit #{snapshot.commit_count} sha #{c.sha[0,6]} #{c.commit.message}"
		    snapshot.tags[c.sha[0,6]] = SnapShotDesc.extract_tags(c.commit.message)

		    snapshot.loc_touched += commit_resp.stats.total.to_i
		    snapshot.deletes += commit_resp.stats.deletions.to_i
		    snapshot.additions += commit_resp.stats.additions.to_i

		    touched_this_commit = commit_resp.files.size
		    snapshot.commit_count += 1
		    snapshot.files_touched += touched_this_commit
		    if (touched_this_commit > snapshot.max_commit_size) 
		    	snapshot.max_commit_size = touched_this_commit
		    end
		    snapshot.messages << [c.sha[0..6] , c.commit.message ]
		end
		snapshots.keys.each  do |email|
			s = snapshots[email]
			puts "Stats for #{email} @ #{repo}"
			puts "\ttotal commits #{s.commit_count}"
			puts "\tavg files touched per commit #{s.files_touched/s.commit_count}"
			puts "\tmax files touched in single commit #{s.max_commit_size}"
			puts "\tavg loc touched #{s.loc_touched/s.commit_count}"
			puts "\tavg deletes #{s.deletes/s.commit_count}"

			puts "\tavg additions #{s.additions/s.commit_count}"
			puts "\ttags #{s.tags.inspect}"
			persist(user, repo, s, email) if  persist
			
		end
	else 
		puts "No commits in #{repo} since #{since}"
	end

end



if opts[:user].blank? || opts[:repo].blank?
	repos = {  	"dbhaug" => "ratings-app",
	       	"ehansh" => "jury_project",
	       	"kuemerle5" => "takeit",
	      	"llhupp"  => "web_sys",
	      	"mxales11" => "gpa_calculator_app",
	      	"ndlloyd" => "nlloyd-cs380-project",
	      	"Tripleberryflip" => "event_app",
	      	"djcorp10" => "pma_app",
	      	"gabegrundtner" => "paintball" }
else 
	repos = { opts[:user] => opts[:repo]}
end

since = (DateTime.now.utc-opts[:since].to_i).iso8601 
if opts[:since_last]
   since = Tracking.order("created_at DESC").first.created_at.iso8601 rescue nil 
end

puts "Tracking since #{since}"
Tracking.create! unless opts[:no_persist] || opts[:track] == false
repos.each_pair { |user, repo| fetch_commits(user, repo, since, (not opts[:no_persist])) }


