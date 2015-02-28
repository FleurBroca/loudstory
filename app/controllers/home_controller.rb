class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @tracks = Track.all.order(:position)
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
      session[:modal] = true
      redirect_to pricing_path
    else
      render :new
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
      customer = Stripe::Customer.retrieve(customer_id)
    end


    customer.subscriptions.create(:plan => "member", quantity: 1)

    @user.save
    if @user.save
      UserMailer.welcome_member_plan(@user).deliver
      redirect_to pricing_path, notice:"you just subscribed to the Member plan"
    else
      redirect_to pricing_path, error:"problem!"
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to pricing_path
  end

  def unsubscribe
    @user = current_user
    @user.member = false
    

    customer_id = current_user.stripe_customer_id
    subscriptions = Stripe::Customer.retrieve(customer_id).subscriptions.all

    current_subscription = subscriptions.first
    current_subscription.quantity -= 1
    current_subscription.save

    @user.save
    if @user.save
      redirect_to pricing_path, alert:"you just unsubscribed to the Member plan"
    else
      redirect_to pricing_path, error:"problem!"
    end

  end

  def mentor
    @user = current_user
    @mentor = Mentor.new(mentor_params)
    @mentor.save
    session[:modal] = false
    redirect_to root_path, notice:"We thank you for your request and promise a pro will get back to you within 48 hours. Check your inbox!"
  end

  private

  def mentor_params
    params.require(:mentor).permit(:tool, :language, :deadline)
  end
end