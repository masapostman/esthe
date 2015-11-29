class StaffMember < ActiveRecord::Base

	include EmailHolder
	include StaffPersonalNameHolder

	has_many :events, class_name: 'StaffEvent', dependent: :destroy

	#has_many :orders, class_name: 'Loanorder', dependent: :destroy

	#before_validation do
	#	self.email_for_index = email.downcase if email
	#end	

	validates :email, presence: true

	validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2015, 1, 1),
    before: ->(obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  validates :end_date, date: {
    after: :start_date,
    before: ->(obj) { 1.year.from_now.to_date },
    allow_blank: true
  }





	#validates :password, presence: true
   #     length:     {within: 6..30}

  has_secure_password


	#def password=(raw_password)
	#	#self[:password] = raw_password
	#	if raw_password.kind_of?(String)
	#		self.hashed_password = BCrypt:: Password.create(raw_password)
	#	elsif raw_password.nil?
	#		self.hashed_password = nil
	#	end
	#end

	def active?
		!suspended? && start_date <= Date.today &&
		(end_date.nil? || end_date > Date.today)
	end
end
