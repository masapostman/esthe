class Customer < ActiveRecord::Base
	include EmailHolder
	include CustomerPersonalNameHolder
  belongs_to :company

	#has_many :orders, class_name: 'Loanorder', dependent: :destroy

	#before_validation do
	#	self.email_for_index = email.downcase if email
	#end	

	validates :company_id,:store_code, :store_name,
  					:email,  presence: true

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
	#:start_date, presence: true


	#validates :password, presence: true
   #     length:     {within: 6..30}

  has_secure_password

	def active?
		!suspended? && start_date <= Date.today &&
		(end_date.nil? || end_date > Date.today)
	end
end
