require 'rubygems'
require 'json'

class FileSystem

  attr :root
  attr_accessor :tweet_size

  def initialize(persister)
    @persister = persister
    @tweet_size = 500
    tweet = @persister.get_most_recent_tweet()

    @root = Directory.new(self, tweet.id)
  end
  
  def load(id)

    completeddata = ""
    
    # Get text data for id
    tweet = @persister.get_tweet(id)
    begin

      data = JSON.parse(tweet.annotation)
      completeddata += data["d"]

      if(tweet.content != "")
         tweet = @persister.get_tweet(tweet.content.to_i)
      else
        tweet = nil
      end
    end while tweet != nil 

    completeddata
  end 
  
  def write(data)
    
    # Writes string to nodes
    data.

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