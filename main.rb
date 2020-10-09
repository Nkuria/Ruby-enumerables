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

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    arr = to_a
    while i < arr.length
      yield(arr[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    arr = to_a
    final_array = []
    arr.my_each { |x| final_array.push(x) if yield(x) }
    final_array
  end

  def my_all?(arg = nil)
    arr = to_a
    if block_given?
      arr.my_each { |x| return false if yield(x) == false }
      return true
    elsif arg.nil?
      arr.my_each { |x| return false if x == false || x.nil? }
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
        return true if yield(x)
      end
      return false

    elsif !arg.nil? && (arg.is_a? Class)
      my_each { |x| return true if [x.class, x.class.superclass].include?(arg) }

    elsif (arg.is_a? Regexp) && !arg.nil?
      my_each { |x| return true if x.match(arg) }

    elsif arg.nil?

      my_each { |x| return true unless x == false || x.nil? }

    else
      my_each do |x|
        return true if x == arg
      end

    end
    false
  end

  def my_none?(args = nil)
    if block_given?
      my_each { |x| return false if yield(x) }
    elsif (args.is_a? Regexp) && !args.nil?
      my_each { |x| return false if x.match(args) }
    elsif args.nil?
      my_each { |x| return false if x }
    elsif !args.nil? && (args.is_a? Class)
      my_each { |x| return false if [x.class, x.class.superclass].include?(args) }
    else
      my_each { |x| return false if x == args }
    end
    true
  end

  def my_count(args = nil)
    x = 0
    if block_given?
      my_each { |z| x += 1 if yield z }
    elsif !args.nil?
      my_each { |z| x += 1 if z == args }
    else
      my_each { |z| x += 1 if z }
    end
    x
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
