module Enumerable
    def my_each
    return to_enum unless block_given?
      i = 0
      arr = to_a
      while i < arr.length
        yield(arr[i])
        i += 1
      end
      self
    end      
    [1,2,3].my_each { |n| puts "#{n}!" }
  
    def my_each_each_with_index 
      return to_enum unless block_given?
      i = 0
      arr = to_a
      while i < arr.length
        yield(arr[i], i)
        i += 1
      end
      self
    end
    [1,2,3].my_each_each_with_index { |n, x| print x }
    
    def my_select
      return to_enum unless block_given?
      arr = to_a
      final_array = []
      arr.my_each {|x| final_array.push[x] if yield(x)}
    end
    [1,2,3,4,5,6,7,8,9,10].my_select {|x| puts x if x.even? }
    end
  
    def all(args)
      arr = to_a
        if block_given?
          arr.my_each {|x| return true unless yield(x) == false}
        elsif args.empty
          return false
        elsif !arg.empty? && (args.is_a? Regexp)
          arr.my_each { |x| return false unless x.match(args) }
        elsif  (arg.is_a? Class) && !args.empty? 
          arr.my_each { |x| return false unless [x.class, x.class.superclass].include?(args) }
        else
          to_a.my_each { |i| return false if i != arg }
        
      end
      true
      
    end
    