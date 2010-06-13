class Foo
	@method = nil
	
	def do_something()
		@method = Proc.new { foo }
		@method.call
	end
	
	def do_something_else()
		@method = Proc.new { bar }
		@method.call
	end
	
	def foo()
		puts 'Foo'
	end
	
	def bar()
		puts 'Bar'
	end
	
end


f = Foo.new
f.do_something()
f.do_something_else()