class Staff::CustomersController < Staff::Base
  def index
    #@company = Company.all
    @customer = Customer.joins('INNER JOIN companies ON customers.company_id = companies.company_code')
                        .select('customers.*,companies.company_code,companies.company_name')
    #@customer = Customer.all
    @customer = @customer.page(params[:page])
  end

  def show
    customer = Customer.find(params[:id])
    redirect_to [ :edit, :staff, customer ]
  end
  def print
    @customer = Customer.find(params[:id])
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
    if @customer.save!
      flash.notice = 'お客様情報を新規登録しました。'
      redirect_to :staff_customers
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
        redirect_to :staff_customers
      else
        render action: 'edit'
      end
   #else
   #    render action: 'edit'
   # end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy!
    flash.notice = 'お客様情報を削除しました。'
    redirect_to :staff_customers
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
  def customer_params
    params.require(:customer).permit(
      :company_id, :company_name,:store_code, :store_name,
      :staff_family_name, :staff_given_name, :staff_family_name_kana, :staff_given_name_kana,
      :postal_code, :prefecture, :city, :address1, :address2, :telephone_number,
      :fax_number, :email, :start_date,:end_date,:suspended, :parent_and_child, :password
      )
  end
end
