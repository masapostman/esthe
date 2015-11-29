class Customer::LoanordersController < Customer::Base
	def index
		@max = Loanorder.maximum(:update_datetime)
		@customer = Customer.where(company_id: session[:company_code])
		@company_code = session[ :company_code]
		#2015/10/24 店舗での絞り込みをもらしていた
		#ActiveModelに店舗コードを渡すため、search_formの引数を追加
		@store_code   = session[ :store_code].to_s	
		if session[:parent_and_child] == '親'  then
			@search_form = Customer::LoanorderSearchForm.new(params[:search])
			@loanorders = @search_form.search(session[ :company_code],session[ :store_code],'1').page(params[:page]).per(14)
			@total = @search_form.search(session[ :company_code],session[ :store_code],'1').group(:company_id).sum(:application_money)
		else
			@search_form = Customer::LoanorderSearchForm.new(params[:search])
			@loanorders = @search_form.search(session[ :company_code],@store_code,'2').page(params[:page]).per(14)
			@total = @search_form.search(session[ :company_code],@store_code,'2').group(:company_id).sum(:application_money)
		end
	end
end
