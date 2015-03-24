require "subscribe_to_newsletter"

class SubscribersController < ApplicationController
  def create
    begin
      SubscribeToNewsletter.new.run(params[:email])

      flash[:notice] = "You successfully subscribed to the Newsletter!"
    rescue Gibbon::MailChimpError => exception
      flash[:alert] = "Unable to subscribe to the newsletter: #{exception.message}"
    end
    redirect_to root_path
  end
end