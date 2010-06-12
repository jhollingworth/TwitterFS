class FileSystem

  attr :root

  def initialize(persister)
    @persister = persister
    tweet = @persister.get_most_recent_tweet()

    @root = Directory.new(self, tweet.id)
  end
  
  def load(id)
    
    # Get text data for id
    

  end 
  
  def write(data)
    
    # Writes string to nodes

    # Returns id

  end
  
  def flush()

    # Bottom up recursion saving all files + directories

  end
end



# This will be replaced with a proper Twitter interface when we get access

class Persister

  def initialize()
    @tweets = Array.new
  end

  def add_tweet(tweet, annotation)
    newtweet = Tweet.new(nil, tweet, annotation)
    @tweets.push(newtweet)
    newtweet.id = @tweets.length-1
    newtweet.id
  end
  
  def get_tweet(id)
    tweet = @tweets[id]
  end

  def get_most_recent_tweet()
    tweet = @tweets[@tweets.length-1]
  end
end

# This is a tweet
class Tweet

  attr :annotation
  attr_accessor  :id
  attr_accessor  :content

  def initialize(id, content, annotation)
    @annotation = annotation
    @id = id
    @content = content
  end

end