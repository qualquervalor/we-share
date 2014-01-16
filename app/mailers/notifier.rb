class Notifier < ActionMailer::Base
  default from: "bluebluevalor@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.borrowrequest_confirmation.subject
  #

  # This sends an email to the User who is requesting to use the resource
  def borrowrequest(user,msg)
    @user = user
    @msg = msg
    mail( to: "#{user.name} <#{user.email}>", 
          subject: "Borrow Request has been sent to the to Owner"
          )
  end

  # This sends an email to the Owner who owns the resource. 
  def borrowrequesttoowner(user,msg,resource)
    @user = user
    @msg = msg
    @resource = resource
     mail( to: "#{user.name} <#{user.email}>", 
          subject: "Borrow Request from The Shed: Please review!"
          )
  end
   
  # This sends an email to the User who is requesting to use the resource. 
  # Sent when status is changed from pending to borrowed (accepted!).  
  def borrowaccept(user,msg)
    @user = user
    @msg = msg

    mail( to: "#{user.name} <#{user.email}>", 
          subject: "Borrow Request has been reviewed - ACCEPTED")
  end

  # This sends an email to the User who is requesting to use the resource. 
  # Sent when status is changed from pending to denied.
  def borrowdenied(user,msg)
  @user = user
  @msg = msg

    mail( to: "#{user.name} <#{user.email}>", 
          subject: "Borrow Request has been reviewed - DENIED")
  end

end
