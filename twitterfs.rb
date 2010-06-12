require 'base64'

class Directory
  attr_accessor :id
  
  def initialize(fs, id)
    @fs = fs
    @id = id
    @loaded = false
  end
  
  def add_file(file)
    load
    @id = nil
  end
  
  def add_directory(dir)
    load
    @id = nil
  end
  
  def files()
    load
    @files
  end
  
  def title()
    load()
    @title
  end
  
  
  def directories()
    load
    @directories
  end

  def load()
    if false == @id.nil? and false == @loaded

      data = @fs.load(@id)
    
      @title = data
      
      @files = [] #load the file
      @directories = [] #load dir
      
      #deserialize
      #foreach(var node in data)
        #if node.type == "Directory"
          #@directories << Directory.new(@fs, node.id)
        #elsif node.type == "File"
          #@files << File.new(@fs, node.id)
      
      @loaded = true
    end
  end
  
  def to_s()
    #serialize dir to string
  end 

end 

class File
  attr_writer :id

  def initialize(fs, id)
    @fs = fs
    @id = id
    @loaded = false
  end

  def title()
    load
    @title
  end

  def data()
    load
    @data
  end
  
  def load()
    if false == @id.nil? and false == @loaded
      
      data = @fs.Load(@id)
      
      puts "foo" + data
      
      
      @title = data
      @files = [] #load the file
      @directories = [] #load dir
      
      #deserialize
      #foreach(var node in data)
    end
  end
  
  def to_s()
    #serialize file to string
  end
end 



