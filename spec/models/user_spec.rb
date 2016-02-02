require 'rails_helper'


RSpec.describe User, :type => :model do
  describe 'validations' do
    it do
      should validate_presence_of :username
    end
    it do
      should validate_presence_of :password_digest
    end
    it do
      should validate_presence_of :session_token
    end
  end
end
