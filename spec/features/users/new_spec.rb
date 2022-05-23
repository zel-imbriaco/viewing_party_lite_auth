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
    it 'requires password and password_confirmation to be identical' do
      within '#new-user-form' do
        fill_in :email, with: 'lorem@ipsum.dorum'
        fill_in :password, with: 'test'
        fill_in :password_confirmation, with: 'test'
        click_on :submit
      end

      expect(current_path).to eq('/users/new')
      expect(flash[:alert]).to be_present
    end
  end
end
