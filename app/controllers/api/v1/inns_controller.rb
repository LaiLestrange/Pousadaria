class Api::V1::InnsController < Api::V1::ApiController

  def details
    inn = Inn.where('registration_number like ?', "%#{params[:query]}%")
    if inn.present?
      
    end

  end

end

=begin
  def search
    buffets = Buffet.where('brand_name like ?', "%#{params[:query]}%")
    if buffets.present?
      render status: 200, json: buffets
    else
      msg = "Não há buffet com #{params[:query]} no nome"
      render status: 200, json: {errors: msg}
    end
  end
=end
