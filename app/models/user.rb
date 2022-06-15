# frozen_string_literal: true
require 'securerandom'

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  include DeviseTokenAuth::Concerns::User

  before_create :add_uuid

  private
    def add_uuid
      uuid = SecureRandom.uuid
      self.uuid = uuid
    end
end
