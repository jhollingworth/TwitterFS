http://github.com/robashton/TwitterFS.gitrequire 'twitterfs'
require 'twitterfspersistance'


class MockPersisterForInitialize
    def initialize
      
    end

    def get_most_recent_tweet()
      tweet = Tweet.new(999, "", "")
    end
end

class MockPersisterForLoad
     def initialize
     end

     def get_most_recent_tweet()
      tweet = Tweet.new(999, "", "")
    end

     def get_tweet(uid)
       tweet = nil
       case uid
         when 1
             tweet = Tweet.new(1, "2", "{\"d\":\"d1\"}")
         when 2
             tweet = Tweet.new(2, "3", "{\"d\":\"d2\"}")
         when 3
              tweet = Tweet.new(3,"4", "{\"d\":\"d3\"}")
         when 4
              tweet = Tweet.new(4, "", "{\"d\":\"d4\"}")
       end
       tweet
     end
end

class MockPersisterForWrite

     attr_accessor :tweets

     def initialize
       @tweets = Array.new
     end

     def get_most_recent_tweet()
      tweet = Tweet.new(999, "", "")
     end

     def add_tweet(tweet, annotation)
        newtweet = Tweet.new(nil, tweet, annotation)
        @tweets.push(newtweet)
        newtweet.uid = @tweets.length-1
        newtweet.uid
     end
end

describe FileSystem, '#load' do

  before(:all) do
    @persister = MockPersisterForLoad.new
    @fs = FileSystem.new(@persister)

    @data = @fs.load(1)
  end

  it "should load all the data for that node" do

    @data.should == "d1d2d3d4"

  end
end

describe FileSystem, '#write' do

    before(:all) do

      @persister = MockPersisterForWrite.new
      @fs = FileSystem.new(@persister)
      @fs.tweet_size = 10

      @fs.write("123456789,223456789,323456789")
    end

    it "should split content into multiple tweets" do
      @persister.tweets.length.should == 3
    end

    it "should create back referenced tweets" do

      @persister.tweets[0].content.should == ""
      @persister.tweets[1].content.should == "0"
      @persister.tweets[2].content.should == "1"

      @persister.tweets[0].annotation.should == "{\"d\":\"323456789\"}"
      @persister.tweets[1].annotation.should == "{\"d\":\"223456789,\"}"
      @persister.tweets[2].annotation.should == "{\"d\":\"123456789,\"}"

    end
end

describe FileSystem, '#initialize' do

  before(:all) do
    @persister = MockPersisterForInitialize.new
    @fs = FileSystem.new(@persister)
  end

  it "should have a root directory" do
    @fs.root.should_not == nil
  end

  it "root directory loaded with most recent uid" do
      @fs.root.uid.should == 999
  end

end

describe Persister, "#get_tweet" do

  before(:all) do
    @persister = Persister.new

    @persister.add_tweet("tweet one", "something")
    @requestuid = @persister.add_tweet("tweet two", "something 2")
    @persister.add_tweet("tweet three", "something 2")

    @requestedtweet = @persister.get_tweet(@requestuid)

  end

  it "should return the tweet specified" do

     @requestedtweet.content.should == "tweet two"
     @requestedtweet.annotation.should == "something 2"
  end

end

describe Persister, '#add_tweet' do

  before(:all) do
    @persister = Persister.new
    @added_uid = @persister.add_tweet("Hello", "Content")
  end

  it "should return the new tweet uid" do
    @added_uid.should_not == nil
  end

  it "should add the Document so it can be retrieved" do

    tweet = @persister.get_tweet(@added_uid)
    tweet.should_not == nil

  end

  it "should add the Document with correct values" do

    tweet = @persister.get_tweet(@added_uid)
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