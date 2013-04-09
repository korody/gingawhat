# encoding:   utf-8
class ContactMailer < ActionMailer::Base
  default from: "noreply@youdomain.dev"
  default to: "hello@gingawhat.com"

  def new_message(message)
    @message = message
    mail(assunto: "olá do gingawhat.com: #{message.assunto}")
  end
end
