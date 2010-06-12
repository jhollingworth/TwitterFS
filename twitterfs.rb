require 'base64'

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
  attr :name
  attr :data
  attr :name
  attr :next
    
  def initialize(name, data)
    @name =name
    @data = data
  end
end

class FileSystem
  
  attr :root

  def initialize(persister)
    @persister = persister
    @root = Directory.new(nil, "root")
  end
end

class Persister

  def initialize()
    @tweets = Array.new
  end

  def add_tweet(tweet, annotation)
    newtweet = Tweet.new(nil, tweet, annotation)
    @tweets.push(newtweet)
    newtweet.set_id(@tweets.length-1)
    newtweet.id
  end

  def get_tweet(id)
    tweet = @tweets[id]
  end

  def get_most_recent_tweet()
    tweet = @tweets[@tweets.length-1]
  end
end

class Tweet
<<<<<<< HEAD
  attr :annotation, :id, :content
  
=======
  attr :annotation
  attr_writer :id
  attr_writer :content

>>>>>>> a8e42294df0896c26930d1af4e2bd40843bfe702
  def initialize(id, content, annotation)
    @annotation = annotation
    @id = id
    @content = content
  end

  def set_id(id)
    @id = id
  end
end