class Directory

  attr :id
  attr :name
  attr :files
  
  def initialize(id, name)
    @id = id
    @name = name
    @files = []
  end

  def add_file(name, content)
    file = File.new(name, content)
    files << file
    file
  end

end

class File   
  attr :name,:data

  def initialize(name, data)
    @name =name
    @data = data
  end
end

class Fs
  attr :root

  def initialize()
    @root = Directory.new(nil, "root")
  end
end

class Persister

  def initialize()
  end

  def add_tweet(tweet, annotation)

  end

  def get_tweet(id)
  end

  def get_most_recent_tweet()
    
  end
end

class Tweet
  attr :annotation, :id, :content
  
  def initialize()
    @annotation = nil
    @id = nil
    @content = nil
    
    puts @annotation
    
    
  end
end