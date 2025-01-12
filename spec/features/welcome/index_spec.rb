require 'rails_helper'

RSpec.describe 'Landing/Welcome Page' do 

  describe 'As a Visitor' do


    it 'has the title of the application, and a link to login' do
      
      visit "/"

      expect(page).to have_content 'Viewing Party Lite'

      expect(page).to have_link 'Login'
    end 

    it 'links to the login form if not logged in' do
      
      visit "/"

      click_on 'Login'

      expect(current_path).to eq login_path
      
    end 
    

    it 'cannot see user list if a visitor' do
      visit root_path
      
      expect(page).to_not have_content("#existing_users")
    end

    it 'has a link to return back to the landing/welcome page' do #link will be present on every page of application
      
      visit "/"

      click_link "Home"
      expect(current_path).to eq('/')
    end 

    it 'has a button to create a new user' do 
      
      visit "/"
      
      expect(page).to have_button("Create a New User")
      click_button "Create a New User"
      expect(current_path).to eq('/users/new')
    end 
  end 
  describe 'As a user' do
    before :each do
      @skeeter = User.create!(name: 'Skeeter', email: 'skeeter@example.com', password: 'test')
      @lugnut = User.create!(name: 'LugNut', email: 'fatdog@corgi.com', password: 'test')
      @hazel = User.create!(name: 'Hazel', email: 'hazelthehut@food.com', password: 'test')
      
      visit login_path
      fill_in :email, with: @skeeter.email
      fill_in :password, with: @skeeter.password
      click_on :submit    
    end

    it 'shows a list of existing users' do

      visit root_path

      expect(page).to have_content(@skeeter.name)
      expect(page).to have_content(@lugnut.name)
      expect(page).to have_content(@hazel.name)
      
    end

    it 'links to log out a user if logged in' do

      visit root_path

      expect(page).to have_link 'Log Out'
      click_on 'Log Out'

      expect(current_path).to eq '/'
      expect(page).to have_link 'Login'
    end    
  end

end 