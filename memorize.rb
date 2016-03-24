QUESTION_COUNT = 20

if(ARGV.length == 0)
  print "No files passed in!"
end

def match?(input, correct)
  prefixes = ['0', '0x', '0x0']

  input = input.downcase()
  correct = correct.downcase()

  if(input == correct)
    return true
  end

  prefixes.each do |p|
    if(p + input == correct)
      return true
    end
  end

  return false
end

def howlong?(count)
  a = Time.now().to_f()
  yield
  b = Time.now().to_f()

  elapsed = b - a
  puts("That took %f seconds! That's %f seconds per question!" % [elapsed, elapsed / count])
end

atob = {}
btoa = {}

File.open(ARGV.sample(), "r") do |f|
  f.each_line do |line|
    a, b = line.chomp().split(/=>/)
    atob[a] = b
    btoa[b] = a
  end
end

right = 0
wrong = 0

test = [atob, btoa].sample()
howlong?(QUESTION_COUNT) do
  while(right < QUESTION_COUNT)
    puts("--------------------")
    puts("Question %d of %d..." % [right+1, QUESTION_COUNT])
    puts()

    choice = test.keys().sample()
    puts("Question --> %s" % choice)
    print("Answer --> ")
    answer = $stdin.gets().chomp()
    puts()
    if(match?(answer, test[choice]))
      puts("CORRECT!!")
      right += 1
    else
      puts("WRONG! Right answer --> %s" % test[choice])
      wrong += 1
    end

    puts()
    puts("%d right, %d wrong" % [right, wrong])
    puts()
  end
end
