require 'twitterfs'
require 'rubygems'
require 'json'
require 'twitterfspersistance'
require 'rr'


Spec::Runner.configure do |config|
  config.mock_with RR::Adapters::Rspec
end

describe Directory do
  before(:all) do    
    @fs = FileSystem.new nil
    @dir = Directory.new(@fs,1)
    
    stub(@fs).load.returns "title;2,3;4,5" 
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
end
