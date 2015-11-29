class Customer::SessionsController < Customer::Base

	skip_before_action :authorize

	def new 
		if current_customer
			redirect_to :customer_loanorders
		else
			@login_form = Customer::LoginForm.new
			render action: 'new'
		end
	end

	def create
    @login_form = Customer::LoginForm.new(params[:customer_login_form])
    if @login_form.valid?
	    if @login_form.email.present?
	      customer = Customer.find_by(email_for_index: @login_form.email.downcase)
	    end
	    if Customer::Authenticator.new(customer).authenticate(@login_form.password)
	    	if customer.suspended?
	    		flash.now.alert = 'アカウントが停止されています。'
	    		render action: 'new'
	    	else
	    		company = Company.where(company_code: customer.company_id).first
	    		if @login_form.remember_me?
	    			cookies.permanent.signed[:customer_id] = customer.id
	    		else
	    			cookies.delete(:customer_id)
	    			session.clear
		        session[:customer_id] = customer.id
	    		end
    			session[:customer_id] = customer.id
	        session[:company_code] = customer.company_id
	        session[:company_name] = company.company_name
	        session[:store_name] = customer.store_name
	        #2015/10/24 店舗での絞り込みをもらしていた
	        session[:store_code] = customer.store_code
	        session[:parent_and_child] = customer.parent_and_child
	        flash.notice = 'ログインしました。'
	        redirect_to :customer_loanorders
	      end
	    else
	      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
	      render action: 'new'
	    end
	  else
	   	render action: 'new'
	   	#render text: @form.errors.full_messages[0]
	  end
  end
  def destroy
  	session.delete(:customer_id)
  	session.clear
  	cookies.delete(:customer_id)
  	flash.notice = 'ログアウトしました。'
  	redirect_to :customer_login
  end
end

