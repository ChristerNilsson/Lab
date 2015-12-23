require 'date'

# todo inför delete
# todo save efter varje ändring. Ej vid quit.
# todo Gå över till json.
# todo till Sinatra
# todo Till iOS. Swift eller Rubymotion
# todo skicka mail om anv ej kollat på x antal dagar.

def assert a,b
  puts "assert: #{a} != #{b} #{caller[0]}" if a != b
end

# order = 1-4
# weekday = 0-6
def meeting date,order,weekday
  d = Date.new(date.year,date.month,1)
  while true
    count = 1 + (d.day-1) / 7
    return d if count==order && d.wday==weekday && d > date
    d += 1
  end
end

assert meeting(Date.new(2015,1,1),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,2),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,3),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,4),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,5),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,6),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,7),2,2), Date.new(2015,1,13)

assert meeting(Date.new(2015,1,8),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,9),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,10),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,11),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,12),2,2), Date.new(2015,1,13)
assert meeting(Date.new(2015,1,13),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,14),2,2), Date.new(2015,2,10)

assert meeting(Date.new(2015,1,15),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,16),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,17),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,18),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,19),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,20),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,21),2,2), Date.new(2015,2,10)

assert meeting(Date.new(2015,1,22),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,23),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,24),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,25),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,26),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,27),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,28),2,2), Date.new(2015,2,10)

assert meeting(Date.new(2015,1,29),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,30),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,1,31),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,2,1),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,2,2),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,2,3),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,2,4),2,2), Date.new(2015,2,10)

assert meeting(Date.new(2015,2,5),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,2,6),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,2,7),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,2,8),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,2,9),2,2), Date.new(2015,2,10)
assert meeting(Date.new(2015,2,10),2,2), Date.new(2015,3,10)
assert meeting(Date.new(2015,2,11),2,2), Date.new(2015,3,10)

def add_delta date,delta
  case delta

  when 'd' ;return date + 1
  when '2d';return date + 2
  when '3d';return date + 3
  when '4d';return date + 4
  when '5d';return date + 5
  when '6d';return date + 6

  when 'w' ;return date + 7
  when '2w';return date + 14
  when '3w';return date + 21
  when '4w';return date + 28
  when '5w';return date + 35
  when '6w';return date + 42

  when 'm' ;return date >> 1
  when '2m';return date >> 2
  when '3m';return date >> 3
  when '4m';return date >> 4
  when '5m';return date >> 5
  when '6m';return date >> 6

  when 'y' ;return date >> 12*1
  when '2y';return date >> 12*2
  when '3y';return date >> 12*3
  when '4y';return date >> 12*4
  when '5y';return date >> 12*4

  when '1sun';return meeting(date,1,0)
  when '1mon';return meeting(date,1,1)
  when '1tue';return meeting(date,1,2)
  when '1wed';return meeting(date,1,3)
  when '1thu';return meeting(date,1,4)
  when '1fri';return meeting(date,1,5)
  when '1sat';return meeting(date,1,6)
    
  when '2sun';return meeting(date,2,0)
  when '2mon';return meeting(date,2,1)
  when '2tue';return meeting(date,2,2)
  when '2wed';return meeting(date,2,3)
  when '2thu';return meeting(date,2,4)
  when '2fri';return meeting(date,2,5)
  when '2sat';return meeting(date,2,6)

  when '3sun';return meeting(date,3,0)
  when '3mon';return meeting(date,3,1)
  when '3tue';return meeting(date,3,2)
  when '3wed';return meeting(date,3,3)
  when '3thu';return meeting(date,3,4)
  when '3fri';return meeting(date,3,5)
  when '3sat';return meeting(date,3,6)

  when '4sun';return meeting(date,4,0)
  when '4mon';return meeting(date,4,1)
  when '4tue';return meeting(date,4,2)
  when '4wed';return meeting(date,4,3)
  when '4thu';return meeting(date,4,4)
  when '4fri';return meeting(date,4,5)
  when '4sat';return meeting(date,4,6)

  else; puts "Unknown delta: #{delta}"
  end
end

class Entry
  attr_accessor :date, :nr, :delta, :text, :fixed
  def initialize date,delta,text,nr
    @date = Date.parse(date)
    @fixed = delta.include?('#') ? '#' : ''
    @delta = delta.delete('#')
    @nr = nr.to_i
    @text = text
  end
  def <=> other
    @date <=> other.date
  end
  def to_s
    "#{'%3d' % @nr} #{@date.strftime('%a')} #{@date} [#{@fixed}#{@delta}] #{@text}"
  end
  def delta= value
    @delta = value
    log
  end
  def date= value
    if @fixed == '#'
      puts "Can't change date"
      return
    end
    @date = value
    log
  end
  def add
    @date = add_delta @date,@delta
    log
  end
  def log
    File.open('log.txt', 'a') { |f| f.puts "#{Time.now} #{@date} #{@nr} #{@fixed}#{@delta} #{@text}" }
  end
end

def load
  @entries = {}
  lines = File.open('data.txt','r').readlines
  lines.each do |line|
    date,nr,delta,*text = line.split(' ')
    text = text.join(' ')
    entry = Entry.new(date,delta,text,nr)
    @entries[entry.nr] = entry
  end
  save "#{Time.now.strftime('%y%m%d')}.txt"
end

def save filename
  File.open(filename,'w') do |f|
    @entries.each do |key,value|
      f.puts "#{value.date} #{value.nr} #{value.fixed}#{value.delta} #{value.text}"
    end
  end
end

def display limit
  puts
  puts "    #{Date.today.strftime('%a')} #{Date.today}:"
  once=false
  list = @entries.values.sort_by {|entry| entry.date}
  list.each do |entry|
    break if entry.date >= Date.today + limit
    if entry.date > Date.today && once==false
      puts
      puts '    Next six days:'
      once=true
    end
    puts entry.to_s
  end
  puts
end

def show_numbers text=''
  puts
  list = @entries.values.sort_by {|entry| entry.nr}
  list.each { |entry| puts "#{entry}" if entry.text.include?(text)}
  puts
end

load
@limit=7

while true
  display @limit
  @limit=7
  print 'Command: '
  line = gets.chomp
  arr = line.split(' ')
  if arr[0]=='?'
    puts ' new yyyy-mm-dd <delta> <text>'
    puts ' <nr> done'
    puts ' <nr> wait <delta>'
    puts ' <nr> get'
    puts ' all'
    puts ' find [<text>]'
    puts ' quit'
    next
  end
  if arr[0]=='new'
    date = arr[1]
    delta = arr[2]
    text = arr[3..-1].join(' ')
    entry = @entries.values.max_by { |e| e.nr }
    entry = Entry.new(date,delta,text,entry.nr+1)
    @entries[entry.nr] = entry
    save 'data.txt'
    next
  end
  if arr[0]=='all'
    @limit=365
    next
  end
  if arr[0]=='find'
    show_numbers arr[1..-1].join(' ')
    next
  end
  if arr[0]=='quit'
    break
  end
  nr = arr[0].to_i
  if nr != 0
    entry = @entries[nr]
    if entry==nil
      puts "Unknown entry: #{nr}"
    end
    case arr[1]
    when 'done'
      entry.add
      save 'data.txt'
    when 'wait'
      entry.date = add_delta(entry.date,arr[2])
      save 'data.txt'
    when 'get'
      entry.date = Date.today
      save 'data.txt'
    else; puts "Unknown verb: #{arr[1]}"
    end
    next
  else
    puts "Error: #{line}"
    next
  end

end

