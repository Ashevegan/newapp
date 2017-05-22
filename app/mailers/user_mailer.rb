
class UserMailer < ApplicationMailer
  default from: "theashley.elyse@gmail.com"

  def contact_form(email, name, message)
    @message = message
    mail(:from => email,
         :to => 'theashley.elyse@gmail.com',
         :subject => "A new contact form message from #{name}")
  end

  def welcome(user)
    @appname = "Bike Nyc"
    mail( :to => user.email,
          :subject => "Welcome to Bike NYC!")
  end
end

