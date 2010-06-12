require 'twitterfs'
require 'rubygems'
require 'json'
require 'twitterfspersistance'
require 'rr'
require 'twitterfs_persistance_tests'

Spec::Runner.configure do |config|
  config.mock_with RR::Adapters::Rspec
end

describe Directory do
  before(:all) do    
    @fs = FileSystem.new MockPersister.new
    stub(@fs).load.returns "title;2,3;4,5" 
    @dir = Directory.new(@fs,1)
    @dir.load
  end
  
  it "should load the title" do
    @dir.title.should == "title"
  end
  
  it "should load the directories" do
    dirs = @dir.directories
    
    dirs.length.should == 2
    dirs[0].id.should == 2
    dirs[1].id.should == 3
  end
  
  it "should load the files" do
    files = @dir.files
    
    files.length.should == 2
    files[0].id.should == 4
    files[1].id.should == 5
  end
  
  it "should serialize a directory to string" do
    
    @dir = Directory.new 1, nil
    @dir.title = "Bibble"
    @dir.add_files([File.new(@fs,10), File.new(@fs,11)])
    @dir.add_directories([Directory.new(@fs,20), Directory.new(@fs,21)])
    
    @dir.to_s.should == "Bibble;20,21;10,11"
  end
end


describe File do 
  before(:all) do 
    @fs = FileSystem.new MockPersister.new
    stub(@fs).load.returns "title;2,3;4,5" 
    @file = File.new(@fs,1)
    @file.load
  end
end