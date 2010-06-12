require 'base64'
require 'ruby-debug'

class Directory
  attr_accessor :uid
  attr_accessor :loaded
  
  def initialize(fs, uid)
    @fs = fs
    @uid = uid
    @loaded = false
    @files = []
    @directories = []
  end
  
  def add_file(file)
    @files << file  
    @uid = nil
  end
  
  def add_directory(dir)
    @directories << dir
    @uid = nil
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
    @uid = nil
  end
  
  def directories()
    load
    @directories
  end

  def load()
    
    if false == @uid.nil? and false == @loaded
      
      data = @fs.load(@uid).split(/;/)
      
      @title = data[0]
      @files = data[2].split(/,/).collect {|i| File.new(@fs, :uid => i.to_i) }
      @directories = data[1].split(/,/).collect{|i| Directory.new(@fs, i.to_i)}
      @loaded = true
    end
  end
  
  def to_s()    
    "#{@title};#{@directories.collect {|d| d.uid.to_s + ','}.to_s.chop};#{@files.collect {|f| f.uid.to_s + ','}.to_s.chop}"
  end 
end 

class File
  attr_accessor :uid
  attr_reader :loaded 
  
  def initialize(fs, options={})
    @fs = fs
    @uid = options.has_key?(:uid) ? options[:uid] : nil
    @title = options.has_key?(:title) ? options[:title] : nil
    @data = options.has_key?(:data) ? options[:data] : nil
    @loaded = false
  end
  
  def title=(title)
    @title = title
    @uid = nil
  end
  
  def data=(data)
    @data = data
    @uid = nil
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
    if false == @uid.nil? and false == @loaded
      data = @fs.load(@uid).split(/;/)
      
      @title = data[0]
      @data = data[1]
    end
  end
  
  def to_s()
    "#{@title};#{@data}"
  end
end 



