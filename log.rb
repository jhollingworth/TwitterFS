class Log

  def self.write(text)
    File.open('log.txt', 'a+') { |f| f.write(text + "\r\n") }
  end                                            


end