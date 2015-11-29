class Staff::LoanorderSearchForm
	include ActiveModel::Model

	attr_accessor :company_name,:company_code

	def search
		rel = Loanorder
		if company_code.present?
			rel = rel.where(company_code: company_code)
		end
	  rel.order("order_date desc")
	end
end