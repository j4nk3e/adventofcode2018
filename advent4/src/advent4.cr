# TODO: Write documentation for `Advent4`
module Advent4
  VERSION = "0.1.0"

  minutes = Array(Hash(Int32, Int32)).new 60 { |i| Hash(Int32, Int32).new }
  active : Int32? = nil
  asleep = false
  lastEvent : Time? = nil
  File.read_lines("input").each do |line|
    match = /\[([0-9]+-[0-9]+-[0-9]+ [0-9]+:[0-9]+)\] (.*)/.match(line)
    t = match.try &.[1]
    if t
      time = Time.parse(t, "%Y-%m-%d %H:%M", location: Time::Location.load("Europe/Berlin"))
      event = match.try &.[2] || ""
      while asleep && active && lastEvent && lastEvent < time
        if lastEvent.hour == 0
          if minutes[lastEvent.minute].has_key?(active)
            minutes[lastEvent.minute][active] = minutes[lastEvent.minute][active] + 1
          else
            minutes[lastEvent.minute][active] = 1
          end
        end
        lastEvent = lastEvent + 1.minute
      end
      if event.starts_with?("Guard")
        active = /Guard #([0-9]+) begins shift/.match(event).try &.[1].to_i
        lastEvent = time
        asleep = false
      elsif event.starts_with?("falls asleep") && lastEvent
        asleep = true
      elsif event.starts_with?("wakes up") && lastEvent
        asleep = false
      end
      lastEvent = time
    end
  end
  guardMinutes = Hash(Int32, Int32).new
  minutes.each_with_index do |m, i|
    m.each do |k, v|
      if guardMinutes.has_key?(k)
        guardMinutes[k] = guardMinutes[k] + v
      else
        guardMinutes[k] = v
      end
    end
  end
  gMax = -1
  gVal = -1
  guardMinutes.each do |g,v|
    if v>gVal
      gMax = g
      gVal = v
    end
  end
  puts "#{gMax} with #{gVal} minutes"
  maxMinute = -1
  maxGuard = -1
  maxTime = -1
  minutes.each_with_index do |m, i|
    m.each do |k, v|
      if v > maxTime
        maxMinute = i
        maxGuard = k
        maxTime = v
        puts "new max: #{i} guard #{k} for #{v} times"
      end
    end
  end
  puts "result: #{maxMinute * maxGuard}"
end
