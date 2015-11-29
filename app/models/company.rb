class Company < ActiveRecord::Base
		has_many :customers, dependent: :destroy
		validates :company_code, :company_name, presence: true
end
