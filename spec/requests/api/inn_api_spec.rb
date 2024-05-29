require 'rails_helper'

describe "Inn API" do
  context "POST /api/v1/inn" do
    it "success" do
      #ARRANGE
      owner = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
      first_inn = Inn.create!(name: 'Pousada dos Devs', active: true, inn_owner: owner, registration_number: '30638898000199', address: Address.new(address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'))
      second_inn = Inn.create!(name: 'Recanto dos Rubistas', active: false, inn_owner: owner, registration_number: '08397842000130')

      first_inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
      first_inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

      #ACT
      post '/api/v1/inn', params: { query: first_inn.registration_number}

      #ASSERT
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse response.body
      expect(json_response.length).to eq 1

    end
  end
end


=begin

> API 1 endpoint
formato json
parametro: cnpj
retorna: nome, cnpj, descricao da pousada, endereço completo, quantidade de quartos

=end
