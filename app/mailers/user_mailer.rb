
class UserMailer < ApplicationMailer
  default from: "from@example.com"

end

  def contact_form(email, name, message)
    @message = message
    mail(:from => email,
         :to => 'theashley.elyse@gmail.com',
         :subject => "A new contact form message from #{name}")
  end

  def welcome(user)
    @appname = "Bike Nyc"
    mail( :to => user.email,
          :subject => "Welcome to #{@appname}!")
  end

end