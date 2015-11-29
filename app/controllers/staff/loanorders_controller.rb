class Staff::LoanordersController < Staff::Base
	require 'date'
	def index
		#@search_form = Admin::LoanorderSearchForm.new
		@max  = Loanorder.maximum(:update_datetime)
  	@loan = Loanorder.select(:company_code,:company_name).uniq
  	#@loanorders = @loanorders.page(params[:page])
  	@search_form = Staff::LoanorderSearchForm.new(params[:search])
  	@loanorders = @search_form.search.page(params[:page]).per(30)
  end

  def import
  # fileはtmpに自動で一時保存される
	  if params[:file].blank?
			redirect_to staff_loanorders_url, notice: "ファイルを選択してください。"	
		else
			file_name = params[:file].original_filename
	  	Loanorder.import(params[:file])
	  	ImportLog.create!(email: session[:email], import_datetime: DateTime.now, import_filename: file_name)
		  redirect_to staff_loanorders_url, notice: "顧客データを追加しました。"
		end
	end
end
