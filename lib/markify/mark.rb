# encoding: utf-8

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
