require 'twitterfs'
require 'rubygems'
require 'json'
require 'twitterfspersistance'

describe "Integration"  do 
  
  it "should be able to persist data with a different file system" do
    

    persister = Persister.new
    fs = FileSystem.new persister
    root = fs.root
    
    filea = File.new(fs, "File A", "Some Data (a)")
    fileb = File.new(fs, "File B", "Some other data (b)")
    
    root.add_files([filea, fileb])
    
    dir = Directory.new(fs, nil)
    filec = File.new(fs, "File C", "Some lovely data (c)")
    dir.add_file(filec)
    
    root.add_directory(dir)
    
    fs.flush()
    
    fs2 = FileSystem.new persister
    
    fs2.root.files.length.should == 2
    fs2.root.directories.length.should == 1
    fs2.root.directories[0].files.length == 1
    fs2.root.directories[0].directories.length == 0
    
    
    
    
  end
  
end