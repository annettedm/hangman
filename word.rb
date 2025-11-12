class Word
  attr_reader :word

  def initialize
    create_word
    initial_word_template
  end

  def initial_word_template
    @template = Array.new(@word.length, "_")
  end

  def template
    @template.join(' ')
  end

  def create_word
    file = prepare_file

    begin
      lines = File.readlines file
    rescue Errno::ENOENT => e
      file_error_instructions e
    rescue => e
      puts "An unexpected file error occurred: #{e.class}, #{e.message}."
    end

    random_word lines
  end

  def file_error_instructions error
    puts "The file '#{file}' could not be found"
    puts "Details: #{e.message}."
    puts "Tried path: #{file_path}."
    puts "Suggestion: Please ensure the file for selecting words is in the current working directory and is not empty."
  end

  def prepare_file
    @word = ''
    file = 'words.txt'
    project_dir = __dir__
    File.join(project_dir, file)
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
