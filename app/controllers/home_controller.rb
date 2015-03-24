class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @tracks = Track.all.order(:position)
    @post = Post.last
  end

  def subscriber
    @list_id = ENV["MAILCHIMP_LIST_ID"]
    gb = Gibbon::API.new

    begin
      gb.lists.subscribe({
        :id => @list_id,
        :email => {:email => params[:email]}
      })

      flash[:notice] = "You successfully subscribed to the Newsletter!"
    rescue Gibbon::MailChimpError => exception
      flash[:alert] = "Unable to subscribe to the newsletter: #{exception.message}"
    end
    redirect_to root_path
  end

  def pricing

  end

  def charge
    @user = current_user
    
    if @user.stripe_customer_id.nil?


      customer = Stripe::Customer.create(
        :email => current_user.email,
        :description => current_user.first_name + " " + current_user.last_name
      )
      card = customer.cards.create(card: params[:stripeToken])
      card.save

      customer_id = customer.id
      current_user.update_attributes(stripe_customer_id: customer_id)
    else
      customer_id = current_user.stripe_customer_id
    end

    Stripe::Charge.create(
      :amount => 17900,
      :currency => "eur",
      :customer => customer_id,
      :description => "#{current_user.email} à payer")

    @user.pro = true
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

    if current_user.stripe_customer_id.nil?

      customer = Stripe::Customer.create(
        :email => current_user.email,
        :description => current_user.first_name + " " + current_user.last_name
      )
      card = customer.cards.create(card: params[:stripeToken])
      card.save
      
      customer_id = customer.id
      current_user.update_attributes(stripe_customer_id: customer_id)
    else
      customer_id = current_user.stripe_customer_id
      customer = Stripe::Customer.retrieve(customer_id)
    end
    

    customer.subscriptions.create(:plan => "member", quantity: 1)
    @user.member = true
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