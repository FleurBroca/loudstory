class UserMailer < ActionMailer::Base
  default from: "fleur@loudstory.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome_free_plan(user)
    @user = user

    mail(to: @user.email, subject: 'Welcome to LoudStory')
    # This will render a view in `app/views/user_mailer`!  end
  end

  def welcome_member_plan(user)
    @user = user

    mail(to: @user.email, subject: 'Welcome to LoudStory')
    # This will render a view in `app/views/user_mailer`!  end
  end

  def welcome_pro_plan(user)
    @user = user

    mail(to: @user.email, subject: 'Welcome to LoudStory')
    # This will render a view in `app/views/user_mailer`!  end
  end
end
