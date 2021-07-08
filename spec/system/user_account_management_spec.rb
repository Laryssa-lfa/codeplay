require 'rails_helper'

describe 'User Account Management' do
  context 'registration' do
    it 'with email and password' do
      visit new_user_registration_path
      fill_in 'Email', with: 'jane@codeplay.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('jane@codeplay.com')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registrar-me')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      visit new_user_registration_path
      click_on 'Criar conta'

      expect(page).to have_text('não pode ficar em branco', count: 2)
      expect(page).to have_link('Entrar')
    end

    it 'password not match confirmation' do
      visit new_user_registration_path
      fill_in 'Email', with: 'jane@codeplay.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123457'
      click_on 'Criar conta'

      expect(page).to have_text('Confirmação de Senha não é igual a Senha')
      expect(page).to have_link('Entrar')
    end

    it 'with email not unique' do
      User.create!(email: 'jane@codeplay.com', password: '123456')

      visit new_user_registration_path
      fill_in 'Email', with: 'jane@codeplay.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_text('Email já está em uso')
    end
  end

  context 'sign in' do
    it 'with email and password' do
      User.create!(email: 'jane@codeplay.com', password: '123456')

      visit new_user_session_path
      fill_in 'Email', with: 'jane@codeplay.com'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('jane@codeplay.com')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registrar-me')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      User.create!(email: 'jane@codeplay.com', password: '123456')

      visit new_user_session_path
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Email ou senha inválida.')
      expect(current_path).to eq(user_session_path)
    end
  end

  context 'logout' do
    it 'successfully' do
      user_login
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('jane@codeplay.com')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Registrar-me')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end
end
