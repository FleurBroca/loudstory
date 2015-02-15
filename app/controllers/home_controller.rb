class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @tracks = Track.all
    @post = Post.last
  end

  def pricing

  end

  def charge
    
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )
    customer_id = customer.id
    current_user.update_attributes(stripe_customer_id: customer_id)

    Stripe::Charge.create(
      :amount => 999,
      :currency => "eur",
      :customer => customer_id,
      :description => "#{current_user.email} à payer"
    )

    redirect_to home_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to pricing_path
  end

end