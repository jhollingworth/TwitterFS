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
    a = "1111111111"
    b = "0000000000"
    file = File.new("foo", a + b)
    file.name.should == "foo"
    file.data.should == a
    file.next.should_not == nil
    file.next.data.should == b
  end
end