require 'pry'

class Object
	attr_accessor :class_to_intercept, :method_to_intercept
end

Object.class_to_intercept = "Test"
Object.method_to_intercept = "stuff"

class Object  
  def self.inherited(base)
    puts Object.method_defined?(:class_to_intercept) 
    puts Object.const_defined?("Test") 
    if Object.const_defined?("Test") 
      if base==Object.const_get(class_to_intercept)
    	def base
    		attr_accessor :method_to_intercept
    	end

    	base.method_to_intercept = method_to_intercept

    	def base.method_added(name)
    		if name == method_to_intercept.to_sym
			    if /hook/.match(name.to_s) or method_defined?("#{name}_without_hook")
			      return
			    end
			    hook = "def #{name}_hook\n binding.pry\n #{name}_without_hook\nend"
			    self.class_eval(hook)

			    a1 = "alias #{name}_without_hook #{name}"
			    self.class_eval(a1)

			    a2 = "alias #{name} #{name}_hook"
			    self.class_eval(a2)
    		end
    	end
      end  
    end
  end
end
puts 23
binding.pry
load './test.rb'
puts 33
