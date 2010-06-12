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

  def initialize(filename)
    @filename = filename
  end

  def add_tweet(tweet, annotation)

  end

  def get_tweet(id)
  end

  def get_most_recent_tweet()
    
  end
end

class Tweet
  attr :annotation
  
  def initialize()
    @annotation = nil
    
    puts @annotation
    
    
  end
end

=begin


class Node
  def initialize(id, next_node)
    @id = id
    @next_node = next_node
  end
end

class Directory < Node
  def initialize(id, name)
    super(id, nil)
    @name = name
    @nodes = []
  end
end

class File < Node
  def initialize(id, data)
     super(id, nil)

     @next_node = []

    @data = data
  end
end

=end 

