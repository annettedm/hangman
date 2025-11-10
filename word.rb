class Word
  attr_reader :word

  def initialize
    create_word
    initial_word_template
  end

  def initial_word_template
    @template_array = Array.new(@word.length, "_")
  end

  def template
    @template_array.join(' ')
  end

  def create_word
    file = 'words.txt'
    project_dir = __dir__
    file_path = File.join(project_dir, file)
    @word = ''

    begin
      lines = File.readlines file
      while !@word.length.between?(5, 12)
        number = Random.rand(10000)
        @word = lines[number].chomp
      end
      @word
    rescue Errno::ENOENT => e
      puts "The file '#{file}' could not be found"
      puts "Details: #{e.message}."
      puts "Tried path: #{file_path}."
      puts "Suggestion: Please ensure the file for selecting words is in the current working directory and is not empty."
    rescue => e
      puts "An unexpected file error occurred: #{e.class}, #{e.message}."
    end
  end

  def check_word entry
    word_match? entry
  end

  def check_letter entry
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
      @template_array[i] = entry if word[i] == entry
    end
  end

  def template_full?
    @word == @template_array.join('')
  end
end
