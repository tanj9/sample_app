require 'sendgrid-ruby'
include SendGrid

class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    from = SendGrid::Email.new(email: 'jerome.tan@tuta.io')
    to = SendGrid::Email.new(email: user.email)
    subject = 'Account activation (Sample App)'
    content = Content.new(type: 'text/html', value: render('user_mailer/account_activation.html.erb'))
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    # puts response.parsed_body
    puts response.headers
  end

  def password_reset#(user)
    @greeting = "Hi"
    mail to: "to@example.org"
#     @user = user
#     from = SendGrid::Email.new(email: 'jerome.tan@tuta.io')
#     to = SendGrid::Email.new(email: user.email)
#     subject = 'Password reset (Sample App)'
#     content = Content.new(type: 'text/html', value: render('user_mailer/password_reset.html.erb'))
#     mail = SendGrid::Mail.new(from, subject, to, content)

#     sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
#     response = sg.client.mail._('send').post(request_body: mail.to_json)
#     puts response.status_code
#     puts response.body
#     # puts response.parsed_body
#     puts response.headers
  end
end
