class SenderController < ApplicationController
  def index

  end

  def send_sms
    require 'callr'
    api = CALLR::Api.new(ENV['login_api'], ENV['password_api'])
    phone = params["phone"].gsub(/[" "]/, '')
    first_name = params["name"]
    last_name = params["family"]
    cst_number = params["csm"]
    if phone.length.between? 10, 12
      add_region = phone.first.gsub(/["0"]/, '+33') + phone[1..11]

      step_of_reconvering = params['step'].to_i

      case step_of_reconvering
      when 1
        if phone.first == "+"
          api.call('sms.send', 'Zenchef', "#{phone}", "Bonjour, j’ai tenté de vous joindre concernant votre formation. Pourriez-vous me rappeler au #{cst_number} ? Merci d’avance. Zenchef", nil)
        else
          api.call('sms.send', 'Zenchef', "#{add_region}", "Bonjour, j’ai tenté de vous joindre concernant votre formation. Pourriez-vous me rappeler au #{cst_number} ? Merci d’avance. Zenchef", nil)
        end
      when 2
        if phone.first == "+"
          api.call('sms.send', 'Zenchef', "#{phone}", "Bonjour, j’ai tenté de vous joindre concernant la mise en place de votre service. Pourriez-vous me rappeler au #{cst_number} ? Merci d’avance. Zenchef", nil)
        else
          api.call('sms.send', 'Zenchef', "#{add_region}", "Bonjour, j’ai tenté de vous joindre concernant la mise en place de votre service. Pourriez-vous me rappeler au #{cst_number} ? Merci d’avance. Zenchef", nil)
        end
      end

      flash[:success] = "SMS #{step_of_reconvering } envoyé à #{last_name} #{first_name}!"
      redirect_to :root
    else
      flash[:error] = 'Le numéro est faux! il contient trop ou pas assez de caractères!'
      redirect_to :root
    end
  end
end
