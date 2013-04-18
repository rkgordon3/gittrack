module SnapShotsHelper
	def snapshot_message_accordian_id(ss)
		"snapshot_message_accordian_#{ss.id}"
	end

	def snapshot_message_table_id(ss)
		"snapshot_message_table_#{ss.id}"
	end

	def snapshot_table_row_id(repo, ss) 
		"snapshot_table_row_id_#{repo.id}_#{ss.id}"
	end
	def snapshot_message_row_id(repo, ss) 
		"snapshot_message_row_id_#{repo.id}_#{ss.id}"
	end
end