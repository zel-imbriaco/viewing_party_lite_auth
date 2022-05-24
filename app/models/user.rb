# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email
  has_secure_password

  enum role: %w(user)

  has_many :attendees
  has_many :parties
  has_many :parties, through: :attendees
end
