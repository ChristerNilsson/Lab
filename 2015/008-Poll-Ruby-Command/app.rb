require 'json'

# Tränar:
# strängar
# konvertering till och från heltal
# textfil
# json med [] {}
# while
# if
# def
# break
# next
# felhantering
# puts gets

# Trick: Replace \{ med \n\{ för att se json på flera rader

# Steg 1 Text + json
# Steg 2 Text + MongoDB
# Steg 3 Sinatra + MongoDB

def show_result(question)
  puts question['question']
  answers = question['answers']
  puts answers.map{|a| a['votes'].to_s + ' ' + a['name']}
  puts
end

def spara(questions)
  File.open('data.json','w') do |f|
    f.write(questions.to_json)
  end
end

def get_integer(prompt,a,b)
  while true
    print prompt
    s = gets.chomp
    return nil if s==''
    i = s.to_i
    return i if a<=i && i<=b
  end
end

questions = JSON.load(File.new('data.json'))
questions.each do |q|
  show_result q
end

while true do
  puts questions.each_with_index.map{|q,i| '(' + (i+1).to_s + ') ' + q['question']}
  qnr = get_integer('Välj en fråga:',1,questions.count)
  break if qnr.nil?
  question = questions[qnr-1]
  answers = question['answers']
  puts answers.each_with_index.map{|a,i| '(' + (i+1).to_s + ') ' + a['name']}
  anr = get_integer('Välj ett svar:',1,answers.count)
  next if anr.nil?
  answer = answers[anr-1]
  answer['votes'] += 1
  show_result(question)
  spara(questions)
end