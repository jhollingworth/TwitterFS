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
