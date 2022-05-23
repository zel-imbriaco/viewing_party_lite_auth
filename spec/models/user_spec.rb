# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest)}
    it { should have_secure_password }
    it 'does not keep the password column' do
      user = User.create(name: 'Zel', email: 'zel@bell.com', password: 'test', password_confirmation: 'test')
      expect(User.find(user.id).password).to eq nil
      expect(user.password_digest).to_not eq 'test'
    end
  end

  describe 'relationships' do
    it { should have_many(:attendees) }
    it { should have_many(:parties) }
    it { should have_many(:parties).through(:attendees) }
  end
end
