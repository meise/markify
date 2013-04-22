class Markify::Database

  attr_reader = :checksums, :path

  def initialize(path = nil)
    @file_path = path || Pathname(ENV['HOME'] + '/markify/hashes.txt')
    @checksums = read_checksums
  end

  def check_for_new_marks(marks)
    new_marks = marks.clone

    read_checksums.each do |line|
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

  protected

  def create_checksum_file
    unless @file_path.dirname.exist?
      @file_path.dirname.mkdir
    end

    File.open(@file_path, 'a+') do |file|
      file.puts "# markify hash database"
    end
  end

  def read_checksums
    hashes = []

    if @file_path.exist?
      hashes = File.open(@file_path, 'r').read.split(/\n/)
    else
      create_checksum_file
    end

    hashes
  end
end