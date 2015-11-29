class Administrator < ActiveRecord::Base
	include EmailHolder

	#before_validation do
	#	self.email_for_index = email.downcase if email
	#end
	has_secure_password
end
