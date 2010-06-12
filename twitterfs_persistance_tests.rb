require 'twitterfs'

class MockPersister
    def initialize
      
    end
end

describe FileSystem, '#initialize' do

  before(:all) do
    @persister = MockPersister.new
    @fs = FileSystem.new(@persister)
  end

  it "should have a root directory" do
    @fs.root.should_not == nil
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


class MockPersister
    def initialize

    end
end

describe FileSystem, '#initialize' do

  before(:all) do
    @persister = MockPersister.new
    @fs = FileSystem.new(@persister)
  end

  it "should have a root directory" do
    @fs.root.should_not == nil
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

  it "should split a file into multiple nodes if it is greater than the max file size" do
    a = "111111111"
    b = "000000000"
    file = File.new("foo", a + b)
    file.name.should == "foo"
    file.data.should == a
    file.next.should_not == nil
    file.next.data.should == b

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
