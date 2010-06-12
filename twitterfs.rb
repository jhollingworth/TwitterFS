require 'base64'
require 'ruby-debug'

class Directory
  attr_accessor :id
  
  def initialize(fs, id)
    @fs = fs
    @id = id
    @loaded = false
    @files = []
    @directories = []
  end
  
  def add_file(file)
    load
    @files << file  
    @id = nil
  end
  
  def add_directory(dir)
    load
    @directories << dir
    @id = nil
  end
  
  def add_files(files)
    files.each { |f| add_file(f)}
  end
  
  def add_directories(directories)
    directories.each { |d| add_directory(d)}
  end
  
  def files()
    load()
    @files
  end
  
  def title()
    load()
    @title
  end
  
  def title=(title)
    load
    @title = title
    @id = nil
  end
  
  def directories()
    load()
    @directories
  end

  def load()
    if false == @id.nil? and false == @loaded

      data = @fs.load(@id).split(/;/)
      
      @title = data[0]
      @files = data[2].split(/,/).collect {|i| File.new(@fs,i.to_i) }
      @directories = data[1].split(/,/).collect{|i| Directory.new(@fs, i.to_i)}
      @loaded = true
    end
  end
  
  def to_s()    
    "#{@title};#{@directories.collect {|d| d.id.to_s + ','}.to_s.chop};#{@files.collect {|f| f.id.to_s + ','}.to_s.chop}"
  end 
end 

class File
  attr_accessor :id

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



