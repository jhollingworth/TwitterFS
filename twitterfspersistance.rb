require 'rubygems'
require 'json'

class FileSystem

  attr_accessor :root
  attr_accessor :tweet_size

  def initialize(persister, options = {})
    @persister = persister
    @tweet_size = 500
    tweet = @persister.get_most_recent_tweet()

    if(options.nil? == false and options.has_key?(:isnew))
       @root = Directory.new self, nil
       flush
     else
       @root = Directory.new(self, tweet.uid)
    end
      
  end

  def load(uid)

    completeddata = ""
    
    # Get text data for uid
    tweet = @persister.get_tweet(uid)
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
    arraycount = (data.length / @tweet_size).to_i
    i = arraycount;
    last_uid = ""    

    begin
        substr =  data[(i * @tweet_size)..((i+1) * @tweet_size-1)]
        last_uid = @persister.add_tweet(last_uid,
                                { "d" => substr }.to_json ).to_s
        
      i -= 1
    end while i >= 0

    # Returns uid
    last_uid.to_i

  end
  
  def flush()
    # Bottom up recursion saving all Documents + directories
    self.flush_directory(@root)
  end

  def flush_directory(dir)

      if(dir.loaded or dir.uid == nil)

        dir.directories.each { |directory|
          flush_directory(directory)
        }

        dir.documents.each { |document|
           flush_Document(document)
        }
        if dir.uid == nil
          dir.uid = self.write(dir.to_s)
        end
      end
  end

  def flush_Document(document)
      if document.uid == nil
        document.uid = self.write(document.to_s)
      end
  end
end


class Persister

  def initialize()
    @tweets = Array.new
  end

  def add_tweet(tweet, annotation)
    newtweet = Tweet.new(nil, tweet, annotation)
    @tweets << newtweet
    newtweet.uid = @tweets.length-1
    newtweet.uid
  end
  
  def get_tweet(uid)
    tweet = @tweets[uid]
  end

  def get_most_recent_tweet()
    tweet = @tweets[@tweets.length-1]
  end
end

# This is a tweet
class Tweet

  attr :annotation
  attr_accessor  :uid
  attr_accessor  :content

  def initialize(uid, content, annotation)
    @annotation = annotation
    @uid = uid
    @content = content
  end

end