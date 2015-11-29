class Admin::CustomersController < Admin::Base

 	def index
    #@company = Company.all
    @customer = Customer.joins('INNER JOIN companies ON customers.company_id = companies.company_code')
                        .select('customers.*,companies.company_code,companies.company_name')
                        .order('companies.company_code', :store_code, :parent_and_child)
    #@customer = Customer.all
    @customer = @customer.page(params[:page])
  end

  def show
    customer = Customer.find(params[:id])
    redirect_to [ :edit, :admin, customer ]
  end
  def print
    #2015/10/15 加盟店名、店舗名を追加
    #@customer = Customer.find(params[:id])
    @customer = Customer.joins('INNER JOIN companies ON customers.company_id = companies.company_code')
                        .select('customers.*,companies.company_name')
                      
    @customer = @customer.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf { render_customer_list(@customer) }
    end
  end
  def new
    @customer = Customer.new
    #@companies = Loanorder.select()
    @loanorders = Loanorder.none
  end

  def edit
  	@customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(customer_params)

    #@loanorders = Loanorder.select(:store_code, :store_name).uniq.order(:store_code).where("company_code = ?", params[:company_code])
  
    @customer.init_password = password_gen(length=8)
    @customer.password = @customer.init_password
    if @customer.save
      flash.notice = 'お客様情報を新規登録しました。'
      redirect_to :admin_customers
    else
      render action: 'new'
    end
  end

  def update_stores
    @loanorders = Loanorder.select(:store_code, :store_name).uniq.order(:store_code).where("company_code = ?", params[:company_code])
    respond_to do |format|
      format.js
      format.xml {render :xml => @stores}
    end
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.assign_attributes(customer_params)
    #if @customer.valid?
	    if @customer.save
	      flash.notice = 'お客様情報を更新しました。'
	      redirect_to :admin_customers
	    else
	      render action: 'edit'
	    end
	 #else
	 #  	render action: 'edit'
	 # end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy!
    flash.notice = 'お客様情報を削除しました。'
    redirect_to :admin_customers
  end
  def confirm
    @customer = Customer.new(customer_params)
    if params[:commit]
      if @customer.valid?
        render action: 'confirm'
      else
        flash.now.alert = '入力に誤りがあります。'
        render action: 'new'
      end
    else
        render action: 'new'
    end
  end

  private
  def render_customer_list(customer)
      report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'print.tlf')

      report.start_new_page
      report.page.item(:created_at).value(@customer.created_at.strftime('%Y/%m/%d'))
      #2015/10/15 加盟店名、店舗名を追加
      report.page.item(:company_name).value(@customer.company_name)
      report.page.item(:store_name).value(@customer.store_name)
      report.page.item(:user_id).value(@customer.email)
      report.page.item(:password).value(@customer.init_password)
      report.page.item(:user_account).value(@customer.email)
      report.page.item(:user_pass).value(@customer.init_password)


      
      send_data report.generate, filename:    "#{@customer.id}.pdf",
                                 type:        'application/pdf', 
                                 disposition: 'inline'
  end
  def customer_params
  	params.require(:customer).permit(
  		:company_id, :company_name,:store_code, :store_name,
  		:staff_family_name, :staff_given_name, :staff_family_name_kana, :staff_given_name_kana,
  		:postal_code, :prefecture, :city, :address1, :address2, :telephone_number,
  		:fax_number, :email, :start_date,:end_date,:suspended, :parent_and_child, :password
  		)
  end
end
