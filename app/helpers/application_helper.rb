module ApplicationHelper
	def mmddyy(dt)
  		dt.strftime("%m-%d-%y")
  	end

  	def tod(dt) 
  		(dt + Time.now.utc_offset.seconds).strftime("%H:%M")
  	end
end
