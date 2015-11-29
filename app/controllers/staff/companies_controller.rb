class Staff::CompaniesController < Staff::Base

  def index
    @companies = Company.order(:company_code)
    @companies = @companies.page(params[:page])
  end

  def show
    company = Company.find(params[:id])
    redirect_to [ :edit, :admin, company ]
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash.notice = '加盟店を新規登録しました。'
      redirect_to :staff_companies
    else
      render action: 'new'
    end
  end

  def update
    @company = Company.find(params[:id])
    @company.assign_attributes(company_params)
    if @company.valid?
	    if @company.save
	      flash.notice = '加盟店を更新しました。'
	      redirect_to :staff_companies
	    else
	      render action: 'edit'
	    end
	   else
	   	render action: 'edit'
	   end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy!
    flash.notice = '加盟店を削除しました。'
    redirect_to :staff_companies
  end
  private

  def company_params
  	params.require(:company).permit(
  		:company_code, :company_name)
  end
end
