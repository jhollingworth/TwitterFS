require 'twitterfs'

fs = Fs.new

describe Fs, '#create' do 
  it "should create a file in twitter" do
    root = fs.root
    root.create("Some data")

    
  end
end