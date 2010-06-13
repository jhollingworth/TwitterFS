require 'rubygems'
require "filesystemwatcher"
require 'twitterfspersistance'
require 'twitterfs'

persister = Persister.new
fs = FileSystem.new persister, :isnew => true

watcher = FileSystemWatcher.new
watcher.addDirectory("fs", "*")
watcher.sleepTime = 1
watcher.start do |status,file|
    if(status == FileSystemWatcher::CREATED) 
        fs.add_file(file) 
        puts "Added #{file} to file store"
    elsif(status == FileSystemWatcher::MODIFIED) 
        fs.add_file(file)
        puts "Modified #{file} in file store"
    elsif(status == FileSystemWatcher::DELETED)
        fs.remove_file(file)
        puts "Removed #{file} from file store"
    end
end

watcher.join() # join to the thread to keep the program alive
