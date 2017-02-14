VERSION = 0.2

# 0.2 Införde Dir[] samt förenklade

# kontrollera.rb ska lista alla .si-filer i underkatalogen ut.
# Detta för att man på ett enkelt sätt ska kunna se vilka filer som ligger där.

def execute_bolag bolag
  Dir[bolag + 'ut/*.si'].each { |f| puts f }
end

def execute
  puts "The following files should be sent to Fortnox or deleted:\n\n"
  Dir['*/'].each { |dir| execute_bolag dir }
end

execute