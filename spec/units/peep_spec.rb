require 'peep'
require 'user'

describe Peep do

  describe 'creation of a new peep' do

    it 'contains a message body' do
      message = "I'm a peep message body"
      peep = Peep.create(message: message)
      expect(peep.message).to eq message
    end

    it 'knows when it was created' do
      message = "I'm a peep message body"
      time = "#{Time.now.hour}" + ":" + "%02d" % Time.now.min.to_s
      peep = Peep.create(message: message)
      expect(peep.created_at.to_s).to include(time)
    end

    it 'has a user who created it' do
      user = User.create(name: 'test', username: 'test', password: 'test', email: 'test@test.com')
      message = "I'm a peep message body"
      peep = Peep.create(message: message, user_id: user.id)
      expect(peep.user_id).to eq(user.id)
    end

  end





end