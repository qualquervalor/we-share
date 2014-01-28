class Notifier < ActionMailer::Base
  # default from: "#{EMAIL_ACCOUNT}"
  
   default from: "#{APP_ADMIN_EMAIL}"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.borrowrequest_confirmation.subject
  #

  # This sends an email to the User who is requesting to use the resource
  def borrow_request(borrow,msg)
    @user = borrow.user
    @resource = borrow.resource
    @owner = borrow.resource.user
    @msg = msg
    mail( to: "#{borrow.user.name} <#{borrow.user.email}>", 
          subject: "Borrow Request has been sent to the Owner"
          )
  end

  # This sends an email to the Owner who owns the resource. 
  def borrow_request_to_owner(user,msg,resource)
    @user = user
    @msg = msg
    @resource = resource
     mail( to: "#{user.name} <#{user.email}>", 
          subject: "Borrow Request from The Shed: Please review!"
          )
  end
   
  # This sends an email to the Owner who owns the resource. 
  def borrow_cancel_to_owner(user,resource)
    @user = user
    @resource = resource
     mail( to: "#{user.name} <#{user.email}>", 
          subject: "Updated Borrow Request from The Shed: Please review!"
          )
  end

  # This sends an email to the User who is requesting to use the resource. 
  # Sent when status is changed from pending to borrowed (accepted!).  
  def borrow_accept(borrow,msg)
    @user = borrow.user
    @resource = borrow.resource
    @owner = borrow.resource.user
    @msg = msg

    mail( to: "#{borrow.user.name} <#{borrow.user.email}>", 
          subject: "Borrow Request has been reviewed - ACCEPTED")
  end

  # This sends an email to the User who is requesting to use the resource. 
  # Sent when status is changed from pending to denied.
  def borrow_denied(borrow,msg)
    @user = borrow.user
    @resource = borrow.resource
    @owner = borrow.resource.user
    @msg = msg

    mail( to: "#{borrow.user.name} <#{borrow.user.email}>", 
          subject: "Borrow Request has been reviewed - DENIED")
  end

end
