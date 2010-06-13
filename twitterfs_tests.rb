require 'twitterfs'
require 'rubygems'
require 'json'
require 'twitterfspersistance'
require 'rr'
require 'twitterfs_persistance_tests'

Spec::Runner.configure do |config|
  config.mock_with RR::Adapters::Rspec
end

class MockPersister 
  def get_most_recent_tweet() end
  
  def get_tweet(uid) end
end

class MockFileSystem
  def initialize(data)
    @data = data
  end
   
  def load(uid)
    @data
  end
end


describe Directory do
  before(:all) do    
    @fs = MockFileSystem.new "title;2,3;4,5" 
    @dir = Directory.new(@fs,1)
    @dir.load
  end
  
  it "should load the title" do
    @dir.title.should == "title"
  end
  
  it "should load the directories" do
    dirs = @dir.directories
    
    dirs.length.should == 2
    dirs[0].uid.should == 2
    dirs[1].uid.should == 3
  end
  
  it "should load the files" do
    files = @dir.documents
    
    files.length.should == 2
    files[0].uid.should == 4
    files[1].uid.should == 5
  end
  
  it "should serialize a directory to string" do
    
    @dir = Directory.new 1, nil
    @dir.title = "Bibble"
    @dir.add_documents([Document.new(@fs,:uid => 10), Document.new(@fs, :uid => 11)])
    @dir.add_directories([Directory.new(@fs,20), Directory.new(@fs,21)])
    
    @dir.to_s.should == "Bibble;20,21;10,11"
  end
end

describe Document do 
  before(:all) do 
    @data = "ABCDEFGHIJ"
    @fs = MockFileSystem.new "title;" + @data 
    @file = Document.new(@fs, :uid => 1)
    @file.load
  end

  it "should load the directory from fs" do
    @file.title.should == "title"
    @file.data.should == @data
  end
  
  it "should serialize a file to string" do 
    @file = Document.new(@fs, :uid => 1)
    @file.title = "Babble"
    @file.data = "ZXCVSKSK"
    @file.to_s.should == "#{@file.title};#{@file.data}"
  end
end