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

class Markify::Mark

  attr_reader :name, :id, :date, :mark, :passed, :try, :hash

  def initialize(name, id, mark, passed, try, date)
    @name   = name
    @id     = id.to_i
    @mark   = mark.to_f
    @passed = passed
    @try    = try.to_i
    @date   = Date.strptime(date, '%d.%m.%Y')
    @hash   = self.to_sha256.to_s
  end

  def to_s
    message =<<MESSAGE
exam:   #{@name}
mark:   #{@mark}
passed: #{@passed}
try:    #{@try}
date:   #{@date}

hash:   #{@hash}

MESSAGE
  end

  def to_sha256
    Digest::SHA256.new << "#{@name}#{@id}#{@date}#{@mark}#{@try}#{@passed}"
  end
end
