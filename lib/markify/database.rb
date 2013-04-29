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

class Markify::Database

  attr_reader :file_path

  def initialize(path = nil)
    @file_path = path || Pathname(ENV['HOME'] + '/markify/hashes.txt')
    @checksums = read_checksum_file
  end

  def check_for_new_marks(marks)
    new_marks = marks.clone

    read_checksum_file.each do |line|
      marks.each do |mark|
        if mark.hash.match(line)
          new_marks.delete(mark)
        end
      end
    end

    new_marks
  end

  def write_checksum(checksum)
    File.open(@file_path, 'a+') do |file|
      file.puts checksum
    end
  end

  def checksums
    checksums = read_checksum_file

    checksums.each do |checksum|
      if checksum.match(/#/)
        checksums.delete(checksum)
      end
    end
  end

  protected

  def create_checksum_file
    unless @file_path.dirname.exist?
      @file_path.dirname.mkdir
    end

    File.open(@file_path, 'a+') do |file|
      file.puts "# markify hash database"
    end
  end

  def read_checksum_file
    hashes = []

    if @file_path.exist?
      hashes = File.open(@file_path, 'r').read.split(/\n/)
    else
      create_checksum_file
    end

    hashes
  end
end