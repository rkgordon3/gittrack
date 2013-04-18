module MessagesHelper
  def message_massage(msg) 
	msg.downcase.gsub(/(user\s*stor(y|ies))/, "<span style='color:red'>\\1</span>").html_safe rescue "No commit comment"
  end
end