class Word
  FILE_NAME = 'words.txt'

  attr_reader :word

  def initialize
    @word = ''

    create_word
    initial_word_template
  end

  def initial_word_template
    @template = Array.new(@word.length, "_") if @word.length > 0
  end

  def template
    @template.join(' ')
  end

  def create_word
    begin
      file = prepare_file
      lines = File.readlines file
      puts 'lines'
      random_word lines unless lines == nil
    rescue Errno::ENOENT => e
      file_error_instructions e
    rescue => e
      puts "An unexpected file error occurred: #{e.class}, #{e.message}."
    end

  end

  def file_error_instructions error
    puts "The file '#{FILE_NAME}' could not be found"
    puts "Details: #{error.message}."
    puts "Suggestion: Please ensure the file for selecting words is in the current directory and is not empty."
  end

  def prepare_file
    file_dir = File.expand_path('../assets', __dir__)

    begin
      File.join(file_dir, FILE_NAME)

    rescue Errno::ENOENT => e
        file_error_instructions e
    rescue => e
        puts "An unexpected file error occurred: #{e.class}, #{e.message}."
      end

  end


  def letter_exists? entry
    if @word.include? entry
      modify_template(entry)
    end
  end

  def word_match? entry
    @word == entry
  end

  def modify_template entry
    word = @word.split ''

    @word.length.times do |i|
      @template[i] = entry if word[i] == entry
    end
  end

  def template_full?
    @word == @template.join('')
  end

  def random_word lines
    until @word.length.between?(5, 12)
      number = Random.rand(10000)
      @word = lines[number].chomp
    end
  end
end
