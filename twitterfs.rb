class Node
  def initialize(id) 
    @id = id
    @next_node = nil
  end
  
  def initialize(id, next_node)
    @id = id
    @next_node = next_node
  end
end

class Directory < Node
  def initialize(id, name)
    super id
    @name = name
    @nodes = []
  end
end

class File < Node
  def initialize(id, data)
    super id
    @data = data
  end
end

class Tweet
  attr text, annotations, id
end


class FS  
  def initialize()
    @root = []
  end
  
  def root_directory()
  end
  
  def create_directory()
  end
  
  def create(file)
  end
  
  def delete(file_id)
  end
  
  def update(file_id, file)
  end
  
  def flush()
  end
end

class Twitter
  def initialize()
    @tweets = []
  end
  
  def tweet(tweet)
    @tweets << tweet
  end
  
  def get_feed(username)
    @tweets
  end
  
  def get_tweet(id)
  end
end
