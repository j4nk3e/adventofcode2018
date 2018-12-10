# TODO: Write documentation for `Advent7`
module Advent7
  VERSION = "0.1.0"
  input = File.read_lines("input")
  req = Hash(Char, Array(Char)).new
  input.each do |line|
    r = line[5]
    c = line[36]
    unless req.has_key?(c)
      req[c] = Array(Char).new
    end
    req[c] << r
  end
  open = (req.values.flatten.to_set | req.keys.to_set).to_a.sort
  puts open
  s = open.size
  order = Array(Char).new
  req.each do |k,v|
    puts "#{k}: #{v.to_s}"
  end
  until open.empty?
    n = open.each do |c|
      unless req.has_key?(c)
        break c
      end
      r = req[c]
      if r.all? { |q| order.includes?(q) }
        break c
      end
    end
    if n.nil?
      puts "Error: unsatisfiable #{open.to_s}"
      break
    end
    order << n
    open.delete(n)
  end
  puts order.join("")
  workers = Hash(Char, Int32).new
  tick = 0
  order = Array(Char).new
  open = (req.values.flatten.to_set | req.keys.to_set).to_a.sort
  until order.size == s
    while workers.size < 5
      n = open.each do |c|
        unless req.has_key?(c)
          break c
        end
        r = req[c]
        if r.all? { |q| order.includes?(q) }
          break c
        end
      end
      if n.nil?
        break
      end
      workers[n] = 60+(n+1-'A')
      open.delete(n)
    end
    tick += 1
    workers.keys.to_a.sort.each do |k|
      workers[k] = workers[k]-1
      if workers[k] == 0
        order << k
        workers.delete(k)
      end
    end
  end
  puts tick
end
