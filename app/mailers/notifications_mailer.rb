class NotificationsMailer < ActionMailer::Base

  def new_contact_request(contact_request)
    @contact_request = contact_request
    photographer = Photographer.cached
    mail( :from => %("#{contact_request.name}" <#{contact_request.email}>), :to => photographer.email, :subject => "New Contact Request", :message => contact_request.message)
  end

end
