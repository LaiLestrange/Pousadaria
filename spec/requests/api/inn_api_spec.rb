require 'rails_helper'

describe "Inn API" do
  context "POST /api/v1/inn" do
    it "success" do
      #ARRANGE
      owner = InnOwner.create!(email: 'leandro@email.com', password: '123456', first_name: 'Leandro', last_name: 'Carvalho', document: '95006658088')
      first_inn = Inn.create!(name: 'Pousada dos Devs', active: true, inn_owner: owner, registration_number: '30638898000199', description: "Um bom lugar pra descansar", address: Address.new(address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'))
      second_inn = Inn.create!(name: 'Pousada da Turma 12', active: true, inn_owner: owner, registration_number: '30638898000200', description: "Um bom lugar pra deugar", address: Address.new(address: 'Rua XYZ', number: '404', city: 'Manaus', state: 'AM', postal_code: '69067-081', neighborhood: 'Centro'))

      first_inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
      first_inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

      #ACT
      post '/api/v1/inn', params: { query: first_inn.registration_number}

      #ASSERT
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse response.body
      expect(json_response["name"]).to eq "Pousada dos Devs"
      expect(json_response["registration_number"]).to eq "30638898000199"
      expect(json_response["description"]).to eq "Um bom lugar pra descansar"
      expect(json_response["address"]).to eq "Rua X, 100 - Centro - Manaus/AM"
      expect(json_response["rooms"]).to eq 2

    end
  end
end
