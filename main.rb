# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop:disable Metrics/ModuleLength
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
    arr.my_each { |x| final_array.push(x) if yield(x) }
    final_array
  end
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_select { |x| puts x if x.even? }

  def my_all?(arg = nil)
    arr = to_a
    if block_given?
      arr.my_each { |x| return true unless yield(x) == false }
      return true
    elsif arg.nil?
      return false
    elsif !arg.nil? && (arg.is_a? Regexp)
      arr.my_each { |x| return false unless x.match(arg) }
    elsif (arg.is_a? Class) && !arg.nil?
      arr.my_each { |x| return false unless [x.class, x.class.superclass].include?(arg) }
    else
      arr.my_each { |i| return false if i != arg }

    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      my_each do |x|
        return true if yield x
      end

    elsif !arg.nil? && (arg.is_a? Class)
      my_each do |x|
        return false unless x.class == arg
      end

    elsif (arg.class == Regexp) && !arg.nil?
      my_each do |x|
        return false unless arg.match(x)
      end

    else
      my_each do |x|
        return true if x == arg
      end

    end
    false
  end

  def my_none?
    return to_enum unless block_given?

    !my_any?
  end

  def my_count(args = nil)
    x = 0
    if block_given?
      my_each { |z| x += 1 if yield(z) == true }
    elsif arg.nil?
      c = length
    else
      my_each { |z| x += 1 if z == args }
    end
    c
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || !proc.nil?

    final = []
    arr = to_a

    if block_given? && proc.nil?
      arr.my_each { |x| final.push(yield(x)) }
    elsif block_given? && !proc.nil?
      arr.my_each { |x| final.push(proc.call(x)) }
    else
      arr.my_each { |x| final.push(proc.call(x)) }

    end
    final
  end

  def my_inject(num = nil, symb = nil)
    if block_given?
      acc = num
      my_each { |x| acc = acc.nil? ? x : yield(acc, x) }
      acc
    elsif symb.is_a?(Symbol) || symb.is_a?(String)
      acc = num
      my_each { |x| acc = acc.nil? ? x : acc.send(symb, x) }
      acc
    elsif num.is_a?(String) || num.is_a?(Symbol)
      acc = nil
      my_each { |x| acc = acc.nil? ? x : acc.send(num, x) }
      acc

    else
      raise LocalJumpError, 'No block Given or Empty Argument' unless !num.nil? && !symb.nil? && !block_given?
    end
  end
end

# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/ModuleLength

def multiply_els(args)
  args.my_inject(1) { |x, y| x * y }
end
