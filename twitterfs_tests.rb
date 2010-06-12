require 'twitterfs'
require 'rubygems'
require 'json'

describe Directory, '#add_file' do
  
  it "should create a create a file" do
    root = Directory.new(1, "test")

    file = root.add_file("lolcat.jpg", "someContent")

    file.should_not == nil
    file.name.should ==   "lolcat.jpg"
    root.files[0].should == file
  end
end

class FileTweeter
  
  attr_writer :max_tweet_size
  
  def initialize(twitter)
    @twitter = twitter
    @max_tweet_size = 512
  end
  
  def tweet_file(file)
    tweet = Tweet.new
    
    puts tweet.methods
    
    tweet.annotation = nil
#    tweet.annotation.data = file
    
    @twitter.tweet(tweet)
  end
end

class FileAnnotation
  attr :data, :next_node
end 


class MockTwitter 
  
  attr :tweets
  
  def initialize()
    @count = 0
    @tweets = []
  end
  
  def tweet(tweet)
    @count = @count + 1
    tweet.id = @count
    @tweets << tweet
    tweet
  end
end

describe FileTweeter, "#tweet_file" do
  
  before(:all) do
    @twitter = MockTwitter.new
    @tweeter = FileTweeter.new(@twitter)
    @tweeter.max_tweet_size = 10
  end
  
  it "should split the file into multiple nodes" do 
    data = "1111111110"
    @tweeter.tweet_file(data)
    @twitter.tweets.length.should == 1
    tweet = tweets[0]
    
    tweet.id.should == 1
    annotation = tweet.annotation 
    annotation.data.should == data
    annotation.next_node.should == nil
  end 
end

describe Fs, '#initialize' do

  before(:all) do
    @fs = Fs.new
  end

  it "should have a root directory" do
    fs.root.should_not == nil
  end

end

describe Persister, "#get_tweet" do

  before(:all) do
    @persister = Persister.new

    @persister.add_tweet("tweet one", "something")
    @requestid = @persister.add_tweet("tweet two", "something 2")
    @persister.add_tweet("tweet three", "something 2")

    @requestedtweet = @persister.get_tweet(@requestid)

  end

  it "should return the tweet specified" do

     @requestedtweet.content.should == "tweet two"
     @requestedtweet.annotation.should == "something 2"
  end

end

describe Persister, '#add_tweet' do

  before(:all) do
    @persister = Persister.new
    @added_id = @persister.add_tweet("Hello", "Content")
  end

  it "should return the new tweet id" do
    @added_id.should_not == nil
  end

  it "should add the file so it can be retrieved" do

    tweet = @persister.get_tweet(@added_id)
    tweet.should_not == nil

  end

   it "should add the file with correct values" do

    tweet = @persister.get_tweet(@added_id)
    tweet.content.should == "Hello"
    tweet.annotation.should == "Content"
     
  end

end

describe Persister, "#get_most_recent_tweet" do

  before(:all) do

    @persister = Persister.new
    @persister.add_tweet("tweet one", "something")
    @persister.add_tweet("tweet two", "something 2")
    @persister.add_tweet("tweet three", "something 3")

    @requestedtweet = @persister.get_most_recent_tweet()

  end

  it "should return the most recent tweet" do
    @requestedtweet.content.should ==   "tweet three"
     @requestedtweet.annotation.should == "something 3"
  end

end
