require 'base64'

class Directory
  attr_accessor :id
  attr_accessor :loaded
  
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
    load
    @files
  end
  
  def title()
    load
    @title
  end
  
  def title=(title)
    load
    @title = title
    @id = nil
  end
  
  def directories()
    load
    @directories
  end

  def load()
    if false != @id.nil? and false == @loaded

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
  attr_reader :id
  attr_reader :loaded 
  
  def initialize(fs, id)
    @fs = fs
    @id = id
    @loaded = false
  end
  
  def initialize(fs, title, data)
    @id = nil
    @fs = fs
    @title = title
    @data = data
  end
  
  def title=(title)
    @title = title
    @id = nil
  end
  
  def data=(data)
    @data = data
    @id = nil
  end
  
  def data()
    load
    @data
  end
  
  def title()
    load
    @title
  end
  
  def load()
    if false == @id.nil? and false == @loaded
      data = @fs.load(@id).split(/;/)
      
      @title = data[0]
      @data = data[1]
    end
  end
  
  def to_s()
    "#{@title};#{@data}"
  end
end 



