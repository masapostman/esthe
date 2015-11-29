class Customer::Authenticator
  def initialize(customer)
    @customer = customer
  end

  def authenticate(raw_password)
    @customer &&
      @customer.password_digest &&
      @customer.start_date <= Date.today &&
      (@customer.end_date.nil? || @customer.end_date > Date.today) &&
      BCrypt::Password.new(@customer.password_digest) == raw_password
  end
end
