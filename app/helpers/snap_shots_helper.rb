module SnapShotsHelper
	def snapshot_message_accordian_id(ss)
		"snapshot_message_accordian_#{ss.id}"
	end

	def snapshot_message_table_id(ss)
		"snapshot_message_table_#{ss.id}"
	end
end