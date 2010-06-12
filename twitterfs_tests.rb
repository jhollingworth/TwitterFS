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


describe File, "#new" do
  
  before(:all) do
    $max_file_size = 10
  end
  
  it "should create a single file if total data under the max" do 
    data = "1111111110"
    file = File.new("foo", data)
    file.name.should == "foo"
    file.next.should == nil
    file.data.should == data
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

=begin 
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
  end

  it "should return the tweet specified" do

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

  end

end


describe Persister, "#get_most_recent_tweet" do

  before(:all) do

  end

  it "should return the most recent tweet" do

  end

end

=end

