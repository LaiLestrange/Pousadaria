class Api::V1::InnsController < Api::V1::ApiController

  def details
    inn = Inn.find_by(registration_number: params[:query])
    if inn.present?
      inn_details = {
        name: inn.name,
        registration_number: inn.registration_number,
        address: inn.full_address,
        rooms: inn.inn_rooms.count,
      }
      inn_details[:description] = inn.description if inn.description.present?
      render status: 200, json: inn_details
    else
      render status: 404, json: { errors: 'Pousadaria não encontrada!'}
    end

  end

end

=begin

> API 1 endpoint
formato json
parametro: cnpj
retorna: nome, cnpj, descricao da pousada, endereço completo, quantidade de quartos

=end
