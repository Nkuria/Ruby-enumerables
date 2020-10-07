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
  [1, 2, 3].my_each { |n| puts "#{n}!" }

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
  [1, 2, 3].my_each_each_with_index { |_n, x| print x }

  def my_select
    return to_enum unless block_given?

    arr = to_a
    final_array = []
    arr.my_each { |x| final_array.push[x] if yield(x) }
  end
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_select { |x| puts x if x.even? }

  def my_all?
    if block_given?
      my_each { |x| return true if yield(x) == true }
    else
      my_each { |x| return true if x == true }
    end
    true
  end

  def my_any?
    if block_given?
      my_each { |x| return false unless yield(x) == true }
    else
      my_each { |x| return false unless x == true }
    end
    false
  end

  def my_none?
    return to_enum unless block_given?

    !my_any?
  end

  def my_count(_args = nil)
    x = 0
    if block_given?
      my_each { |z| x += 1 if yield(z) == true }
    elsif num.nil?
      c = length
    else
      my_each { |z| x += 1 if z == num }
    end
    c
  end

  def my_map(args)
    final = []
    if args == true
      my_each do |x|
        final.push(args).call(x)
      end

      final
    else
      self
    end
  end

  def my_inject(args = nil)
    acc = args.nil? ? first : args
    my_each { |x| acc = yield(acc, x) }
    acc
  end
end

def multiply_els
  my_inject(5, :*)
end
