# encoding:   utf-8
class ContactController < ApplicationController
  
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      ContactMailer.new_message(@message).deliver
      flash[:success] = "Seu contato mantêm o brilho dessa ginga.</br>Obrigado #{@message.nome}!</br>Responderemos em breve : )".html_safe
    else
      respond_to do |format|
        format.html {  }
        format.js
      end
    end
  end

end
