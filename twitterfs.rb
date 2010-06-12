require 'base64'

class Directory

  attr :id
  attr :name
  attr :files
  
  def initialize(id, name)
    @id = id
    @name = name
    @files = []
  end

  def add_file(name, content)
    file = File.new(name, content)
    files << file
    file
  end

end

class File   
  attr :name
  attr :data
  attr :name
  attr :next
    
  def initialize(name, data)
    @name =name
    

  end
end

