class Notifier < ActionMailer::Base
  default from: "jennifer4scales@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.borrowrequest_confirmation.subject
  #

  def borrowrequest(user)
    @user = user

    mail( to: "#{user.name} <#{user.email}>", 
          subject: "Borrow Request Sent to Owner")
  end
    
  def borrowaccept(user)
    @user = user

    mail( to: "#{user.name} <#{user.email}>", 
          subject: "Borrow Request has been reviewed - ACCEPTED")
  end

  def borrowdenied(user)
  @user = user

    mail( to: "#{user.name} <#{user.email}>", 
          subject: "Borrow Request has been reviewed - DENIED")
  end

end
