module ApplicationHelper
	def mmddyy(dt)
  		dt.strftime("%m-%d-%y")
  	end

  	def tod(dt) 
  		dt.strftime("%H:%M")
  	end
end
