class Customer::CustomersController < Customer::Base
	skip_before_action :authorize

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash.notice = 'アカウントを新規登録しました。'
      redirect_to :customer_root
    else
      render action: 'new'
    end
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
  		:company_name, :top_family_name, :top_given_name, :top_family_name_kana, :top_given_name_kana,
  		:staff_family_name, :staff_given_name, :staff_family_name_kana, :staff_given_name_kana,
  		:zip_code, :prefecture, :city, :address1, :address2, :telephone_number, :mobilephone_number,
  		:fax_number, :email, :password
  		)
  end
end
