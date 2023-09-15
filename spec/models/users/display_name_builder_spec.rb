require "rails_helper"

describe User::DisplayNameBuilder do
  describe '#base_display_name' do
    it 'builds the correct display_name' do
      user = User.new(first_name: 'Guntherß Maria', last_name: 'Fröhlich')
      builder = User::DisplayNameBuilder.new user
      expect(builder.base_display_name).to eq 'guntherss_f'
    end

    it 'builds a nice user name if the first name is weird' do
      user = User.new(first_name: '###', last_name: 'fröhlich')
      builder = User::DisplayNameBuilder.new user
      expect(builder.base_display_name).to eq '_f'
    end

    it 'builds a nice user name if the last name is weird' do
      user = User.new(first_name: 'daniel', last_name: '###')
      builder = User::DisplayNameBuilder.new user
      expect(builder.base_display_name).to eq 'daniel'
    end

    it 'builds a random token if last name and first name are weird' do
      user = User.new(first_name: '###', last_name: '###')
      builder = User::DisplayNameBuilder.new user
      expect(builder.base_display_name).to be_present
      expect(builder.base_display_name.size).to eq 10
    end

    it 'builds a random token if user is empty' do
      user = User.new
      builder = User::DisplayNameBuilder.new user
      expect(builder.base_display_name).to be_present
      expect(builder.base_display_name.size).to eq 10
    end
  end

  describe '#next_display_name' do
    it 'builds the next display_name' do
      user = User.new(first_name: 'Donald', last_name: 'Duck')
      builder = User::DisplayNameBuilder.new user
      expect(builder.next_display_name).to eq 'donald_d1'
      expect(builder.next_display_name).to eq 'donald_d2'
    end
  end

  it 'checks if the display_name is already in use and takes the next available', slow: true do
    user1 = User.create(first_name: 'Donald', last_name: 'Duck', email: 'dd1@foo.org', password: 'password', origin_lang: 'en')
    expect(user1).to be_persisted
    expect(user1.display_name).to eq 'donald_d'

    user2 = User.create(first_name: 'Donald', last_name: 'Duck', email: 'dd2@foo.org', password: 'password', origin_lang: 'en')
    expect(user2).to be_persisted
    expect(user2.display_name).to eq 'donald_d1'
  end
end
