require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  scenario 'Verifica link cadastro de cliente' do
    visit root_path
    expect(page).to have_link('Cadastrar clientes')
  end

  scenario 'Verifica Novo Cliente' do
    visit root_path
    click_on 'Cadastrar clientes'
    expect(page).to have_content('Clientes')
    expect(page).to have_link('Novo cliente')
  end

  scenario 'Verifica formulario de clientes' do
    visit customers_path
    click_on 'Novo cliente'
    expect(page).to have_content('Novo Cliente')
  end

  scenario 'Cadastrar um cliente válido' do
    visit new_customer_path
    customer_name = Faker::Name.name

    fill_in 'Nome',	with: customer_name
    fill_in 'Email',	with: Faker::Internet.email 
    fill_in 'Telefone',	with: Faker::PhoneNumber.phone_number
    
    attach_file 'Foto do Perfil', "#{Rails.root}/spec/fixtures/avatar.png"
    choose option: ['S', 'N'].sample
    click_on 'Criar Cliente'

    expect(page).to have_content('Cliente cadastrado com sucesso!')
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario 'não cadastra cliente inválido' do
    visit new_customer_path
    click_on 'Criar Cliente'

    expect(page).to have_content('não pode ficar em branco')
  end
end
