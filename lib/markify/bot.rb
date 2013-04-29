# encoding: utf-8
=begin
Copyright Daniel Meißner <meise+markify@3st.be>, 2013

This file is part of Markify.

Markify is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Markify is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Markify. If not, see <http://www.gnu.org/licenses/>.
=end

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