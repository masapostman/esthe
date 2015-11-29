module EmailHolder
	extend ActiveSupport::Concern

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	included  do
		include StringNormalizer

	  before_validation do
	    #self.email = normalize_as_email(email)
	    self.email_for_index = email.downcase if email

	  end

	  
  	validates :email, format: { with: VALID_EMAIL_REGEX , allow_blank: true}
		#validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
	  validates :email_for_index, uniqueness: { allow_blank: true }

	  after_validation do
    	if errors.include?(:email_for_index)
      	errors.add(:email, :taken)
      	errors.delete(:email_for_index)
    	end
  	end
  end
end