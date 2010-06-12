require 'twitterfs'

describe Directory, '#add_file' do
  
  it "should create a create a file" do
    root = Directory.new(1, "test")

    file = root.add_file("lolcat.jpg", "someContent")

    file.should_not == nil
    file.name.should ==   "lolcat.jpg"
    root.files[0].should == file
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

    file = File.new("testfile.txt", 'w');
    file.close()
    @persister = Persister.new("testfile.txt")
    
  end

  it "should return the tweet specified" do

  end

end

describe Persister, '#add_tweet' do

  before(:all) do
    @persister = Persister.new()
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
     tweet.


  end

end

describe Persister, "#get_most_recent_tweet" do

  before(:all) do

    File.open("testfile.txt", 'w') { |f|

      f.write("")
    }



  end

  it "should return the most recent tweet" do

  end

end