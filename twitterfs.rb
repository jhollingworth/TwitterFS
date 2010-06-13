require 'base64'
require 'ruby-debug'
require 'pathname'

class Directory
  attr_accessor :uid
  attr_accessor :loaded
  
  def initialize(fs, uid)
    @fs = fs
    @uid = uid
    @loaded = false
    @documents = []
    @directories = []
  end
  
  def add_document(document)
    @documents << document  
    @uid = nil
  end
  
  def add_directory(dir)
    @directories << dir
    @uid = nil
  end
  
  def add_documents(documents)
    documents.each { |f| add_document(f)}
  end
  
  def add_directories(directories)
    directories.each { |d| add_directory(d)}
  end
  
  def documents()
    load
    @documents
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
      
      debugger
      data = @fs.load(@uid).split(/;/)

      @title = data[0]
      @documents = data[2].split(/,/).collect {|i| Document.new(@fs, :uid => i.to_i) }
      @directories = data[1].split(/,/).collect{|i| Directory.new(@fs, i.to_i)}
      @loaded = true
    end
  end
  
  def to_s()    
    "#{@title};#{@directories.collect {|d| d.uid.to_s + ','}.to_s.chop};#{@documents.collect {|f| f.uid.to_s + ','}.to_s.chop}"
  end 
  
  def flush(root)
    path = File.directory? root.nil? $root : root + '/' + title
    
    if false == File.directory? path
      Dir.mkdir(path)
    end      
    
    @documents.each { |d| d.flush(path) }
    @directories.each { |d| d.flush(path) }
  end
end 

class Document
  attr_accessor :uid
  attr_reader :loaded 
  
  def initialize(fs, options={})
    @fs = fs
    @uid = options.has_key?(:uid) ? options[:uid] : nil
    @title = options.has_key?(:title) ? options[:title] : nil
    @data = options.has_key?(:data) ? options[:data] : nil
    @loaded = false
  end
  
  def Document.from_file_path(fs, document_path)
    data = nil
    File.open(document_path, 'rb') {|f| data = f.read()}
    Document.new(fs, 
      :title => Pathname.new(document_path).basename,
      :data => data
    )
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

      debugger
      # Google this to find out the better way
      # Tut tut hollingworth...
      rawdata =  @fs.load(@uid)
      data = rawdata.split(/;/)
      
      @title = data[0]
      @data = rawdata[(@title.length+1)..rawdata.length]
    end
  end
  
  def flush(path)
  end
  
  def to_s()
    "#{@title};#{@data}"
  end
end 



