require 'rubygems'
require 'directory_watcher'


=begin
class Watcher < File
  def initialize(fs)
    @fs = fs
    @dir_watcher = DirectoryWatcher.new './fs'
    @dir_watcher.add_observer {|*args| args.each {|event| file_updated(event)}}
    @dir_watcher.start
  end
  
  def file_updated(event)
    
    puts event
    
    if (event =~ /added/) != nil
      puts "Create"
    elsif (event =~ /remove/) != nil
      puts "Delete"
    elsif (event =~ /modified/) != nil
      puts "Update"
    end
  end
end

dw = Watcher.new nil
Thread.new { dw.start }
Thread.new {
  while true
#puts "Bibble"
    sleep 10
  end
}
gets  


=end
