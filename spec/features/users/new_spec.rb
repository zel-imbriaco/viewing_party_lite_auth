# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New User Page', type: :feature do
  it 'Allows a new user to be created' do
    visit '/users/new'

    within '#new-user-form' do
      fill_in :name,	with: 'Zel'
      fill_in :email, with: 'lorem@ipsum.dorum'
      fill_in :password, with: 'test'
      fill_in :password_confirmation, with: 'test'
      click_on :submit
    end

    new_user = User.where(email: 'lorem@ipsum.dorum').first
    expect(current_path).to eq("/users/#{new_user.id}")
  end

  describe 'sad path' do
    before :each do
      visit '/users/new'
    end
    it 'requires new user to enter a name' do
      within '#new-user-form' do
        fill_in :email, with: 'lorem@ipsum.dorum'
        fill_in :password, with: 'test'
        fill_in :password_confirmation, with: 'test'
        click_on :submit
      end

      expect(current_path).to eq('/users/new')
      expect(page).to have_content "Please enter your name."
    end

    it 'requires new users to enter email address' do
      within '#new-user-form' do
        fill_in :name, with: 'Zel'
        fill_in :password, with: 'test'
        fill_in :password_confirmation, with: 'test'
        click_on :submit
      end

      expect(current_path).to eq("/users/new")
      expect(page).to have_content "Please enter your desired email address."
    end

    it 'requires new users to enter a password' do
      within '#new-user-form' do
        fill_in :name, with: 'Zel'
        fill_in :email, with: 'lorem@ipsum.dorum'
        fill_in :password_confirmation, with: 'test'
        click_on :submit
      end
      
      expect(current_path).to eq("/users/new")
      expect(page).to have_content "Please enter a password."
    end

    it 'confirms that the password and confirmation match' do
      within '#new-user-form' do
        fill_in :name, with: 'Zel'
        fill_in :email, with: 'lorem@ipsum.dorum'
        fill_in :password, with: 'thisisa'
        fill_in :password_confirmation, with: 'test'
        click_on :submit
      end

      expect(current_path).to eq("/users/new")
      expect(page).to have_content "Your passwords must match."
    end
  end
end
