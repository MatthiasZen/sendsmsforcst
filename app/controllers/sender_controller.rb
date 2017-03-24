class SenderController < ApplicationController
  def index

  end

  def send_sms
    require 'callr'
    api = CALLR::Api.new(ENV['login_api'], ENV['password_api'])
    phone = params["phone"].gsub(/[" "]/, '')
    first_name = params["name"]
    last_name = params["family"]
    csm_infos = params["csm"].split(",")
    cst_name = csm_infos.first
    cst_number = csm_infos.last
    if phone.length.between? 10, 12
      add_region = phone.first.gsub(/["0"]/, '+33') + phone[1..11]

      step_of_reconvering = params['step'].to_i

      case step_of_reconvering
      when 1
        if phone.first == "+"
          api.call('sms.send', 'Zenchef', "#{phone}", "Bonjour, j’ai tenté de vous joindre concernant votre formation. Pourriez-vous me rappeler au #{cst_number} ? Merci. #{cst_name} de Zenchef", nil)
        else
          api.call('sms.send', 'Zenchef', "#{add_region}", "Bonjour, j’ai tenté de vous joindre concernant votre formation. Pourriez-vous me rappeler au #{cst_number} ? Merci. #{cst_name} de Zenchef", nil)
        end
      when 2
        if phone.first == "+"
          api.call('sms.send', 'Zenchef', "#{phone}", "Bonjour, j’ai tenté de vous joindre pour la mise en place de votre service. Pouvez-vous me rappeler au #{cst_number} ? Merci. #{cst_name} de Zenchef", nil)
        else
          api.call('sms.send', 'Zenchef', "#{add_region}", "Bonjour, j’ai tenté de vous joindre pour la mise en place de votre service. Pouvez-vous me rappeler au #{cst_number} ? Merci. #{cst_name} de Zenchef", nil)
        end
      when 3
        if phone.first == "+"
          api.call('sms.send', 'Zenchef', "#{phone}", "Bonjour, je suis votre nouveau contact chez Zenchef. Vous pouvez me contacter pour faire le point sur votre service au #{cst_number}. #{cst_name}", nil)
        else
          api.call('sms.send', 'Zenchef', "#{add_region}", "Bonjour, je suis votre nouveau contact chez Zenchef. Vous pouvez me contacter pour faire le point sur votre service au #{cst_number}. #{cst_name}", nil)
        end
      end

      flash[:success] = "SMS #{step_of_reconvering } envoyé à #{first_name.capitalize} #{last_name.upcase} !"
      redirect_to :root
    else
      flash[:error] = 'Le numéro est faux! il contient trop ou pas assez de caractères!'
      redirect_to :root
    end
  end
end
