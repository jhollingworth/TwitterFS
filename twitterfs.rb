class IndexNode
  attr_reader :files 

  def initialize(title)    
    @title = title
    @files = []
    @next_node = nil 
  end
  
  def to_s

  end
end

class Node
    
  def initialize(index, data)
    @index = index
    @data = data
  end
  
  def to_s
    @data
  end
  
end


index = IndexNode.new("Master")
node = Node.new(index, "Hello world")

index.files << node

puts index

