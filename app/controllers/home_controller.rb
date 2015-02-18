class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @tracks = Track.all
    @post = Post.last
  end

  def pricing

  end

  def charge

    @user = current_user
    @user.pro = true
    
    if @user.stripe_customer_id.nil?


      customer = Stripe::Customer.create(
        :email => current_user.email,
        :card  => params[:stripeToken]
      )
      customer_id = customer.id
      current_user.update_attributes(stripe_customer_id: customer_id)
    else
      customer_id = current_user.stripe_customer_id
    end

    time_now = Time.new
    time_limit = Time.new(2015,2,22,23,59)

    if @user.member == true && time_now <= time_limit
      Stripe::Charge.create(
        :amount => 17900,
        :currency => "eur",
        :customer => customer_id,
        :description => "#{current_user.email} à payer"
      )
    else
      Stripe::Charge.create(
        :amount => 29900,
        :currency => "eur",
        :customer => customer_id,
        :description => "#{current_user.email} à payer"
      )
    end

    @user.save
    if @user.save
      redirect_to home_path, notice:"you just subscribe to the Pro offers"
    else
      redirect_to pricing_path, error:"problem!"
    end


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to pricing_path
  end

  def member

    @user = current_user
    @user.member = true

    if current_user.stripe_customer_id.nil?

      customer = Stripe::Customer.create(
        :email => current_user.email,
        :card  => params[:stripeToken]
      )
      customer_id = customer.id
      current_user.update_attributes(stripe_customer_id: customer_id)
    else
      customer_id = current_user.stripe_customer_id
    end

    subscriptions = Stripe::Customer.retrieve(customer_id).subscriptions.all

    if subscriptions.any?
      redirect_to home_path, alert:"You have already subscribed to this offer"
    else
      customer.subscriptions.create(:plan => "member", quantity: 1)
    end

    
    @user.save
    if @user.save
      redirect_to home_path, notice:"you just subscribe to the Member offers"
    else
      redirect_to pricing_path, error:"problem!"
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to pricing_path
  end

end