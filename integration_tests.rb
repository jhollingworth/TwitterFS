require 'twitterfs'
require 'rubygems'
require 'json'
require 'twitterfspersistance'
#require 'ruby-debug'

describe "Integration"  do 

  it "should be able to persist data with a different Document system" do

    persister = Persister.new

    fs = FileSystem.new persister, :isnew => true
    root = fs.root
    
    documenta = Document.new(fs, :title => "Document A", :data =>  "Some Data (a)")
    documentb = Document.new(fs, :title => "Document B", :data => "Some other data (b)")
    
    root.add_documents([documenta, documentb])
    
    dir = Directory.new(fs, nil)
    documentc = Document.new(fs, :title => "Document C", :data => "Some lovely data (c)")
    dir.add_document(documentc)
    
    root.add_directory(dir)
    
    
    fs.flush()
    
    fs2 = FileSystem.new persister
    
    fs2.root.documents.length.should == 2
    fs2.root.directories.length.should == 1
    fs2.root.directories[0].documents.length == 1
    fs2.root.directories[0].directories.length == 0
  end
  
  it "should be able to persist an image of an inode" do 
    
    persister = Persister.new 
    
    fs = FileSystem.new persister, :isnew => true
    file = Document.from_file_path(fs, 'inode-detail.jpg')
    
    fs.root.add_document(file)
    fs.flush()
    
    
    fs = FileSystem.new persister
    
    doc = fs.root.documents[0]
    
    doc.title.should == 'inode-detail.jpg'
    File.open('test.jpg', 'w') {|f| f.puts doc.data }
  end
end

