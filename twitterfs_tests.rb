require 'twitterfs'

describe Directory, '#add_file' do
  it "should create a file in twitter" do
    root = Directory.new(1, "test")

    file = root.add_file("lolcat.jpg", "someContent")

    file.should_not == nil
    file.name.should ==   "lolcat.jpg"

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


describe Persister, '#initialize' do
  
end
