class UserMailer < ApplicationMailer
def welcome(user)
  @appname = "Bike Shop"
  mail( :to => user.email,
        :subject => "Welcome to #{@appname}!")
end
