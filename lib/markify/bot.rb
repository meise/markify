# encoding: utf-8

require 'xmpp4r/client'

class Markify::Bot
  def initialize(id, password)
    @client = Jabber::Client.new(id)

    @client.connect
    @client.auth(password)
  end

  def send_message(receiver, message)
    receiver.each do |r|
      @client.send(Jabber::Message.new(r, message))
    end
  end
end