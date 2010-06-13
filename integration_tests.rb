require 'twitterfs'
require 'rubygems'
require 'json'
require 'twitterfspersistance'
require 'Base64'
require 'watcher'
#require 'ruby-debug'

$root = 'fs/'

describe "Integration"  do 

=begin
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

    original = nil
    File.open('inode-detail.jpg', 'rb') { |f| original = f.read()}
      
    fs.root.add_document(file)
    fs.flush()
    
    fs = FileSystem.new persister
    
    doc = fs.root.documents[0]
    
    doc.title.should == 'inode-detail.jpg'
    for i in 0..original.length
      doc.data[i].should == original[i]
    end
    

    File.open('test.jpg', 'wb') {|f| f.write(doc.data) }

  end
  
  it "this isn't even a real test" do

    data = nil
    File.open('inode-detail.jpg', 'rb') { |f| data = f.read()}


    File.open('test1.jpg', 'wb') {|f| f.write(data)
    f.flush()}

   
  end
=end 

  it "should be able to watch for new files beeing created" do

    data = nil
    title = '123456.jpg'
    File.open('inode-detail.jpg', 'rb') { |f| data = f.read()}
    File.open('fs/' + title, 'wb') {|f| f.write(data) }

    persister = Persister.new
    fs = FileSystem.new persister, :isnew => true
    w = Watcher.new fs
    
    sleep(20)
  end
end

