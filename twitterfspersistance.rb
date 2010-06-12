class FileSystem

  attr :root

  def initialize(persister)
    @persister = persister
    @root = Directory.new(nil, "root")
  end
  
  def load(id)
    #get text data for id's
  end 
  
  def write(data)
    #writes string to nodes
  end
  
  def flush()
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

  attr :annotation
  attr_writer :id
  attr_writer :content

  def initialize(id, content, annotation)
    @annotation = annotation
    @id = id
    @content = content
  end

  def set_id(id)
    @id = id
  end
end