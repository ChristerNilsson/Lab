VERSION = 0.7


# 0.7 Lade till 3213 -0.0. Skriver ut obalanserade transar. Lade till UTRIKES

# 0.6 trans: Forcera en nolla om force=true. Skriv ut en nollrad för 1910 om allt är noll.

# 0.5 Införde Dir[] för att hitta katalogerna

# 0.4 innebär att app.rb flyttas ner i katalogen Taxi Stockholm

# 0.3 innebär att kolumnen UTLÄGG ska överföras till konto 1910. Gick över till index istf nycklar pga åäö
# datum skrivs ibland med och ibland utan sekel
# filkolumnerna separeras ibland av tab, ibland av semikolon

DIR1 = '.\\'
REP_COLS = []
COLS = 11
COL_WIDTH = 11

DATUM = 0
PASSNR = 1
VVLEG = 2
TAXINR = 3
INKORT = 4
KREDITER = 5
UTLAGG = 6
ATT_REDOVISA = 7
BUD = 9
PERSONTRSP = 10
UTRIKES = 11

def process_one_file file1,file2,file3
  puts file1
  File.open(file1, 'r') do |f|
    @lines = f.readlines
  end

  @data = []
  @sum = [0,0,0,0,0,0,0,0,0,0,0]
  @lines.each_with_index do |line,i|
    sep = line.include?("\t") ? "\t" : ';'
    cells = line.split(sep)
    if i==0
      @keys = cells
    else
      if cells.size > 10
        arr = cells.map { |cell| cell.strip }
        if arr and arr[DATUM] and arr[DATUM].size >= 8
          arr[DATUM] = '20' + arr[DATUM] if arr[DATUM].size==8
          @data << arr
        end
      end
    end
  end

  def trans f, rate, konto, value, force=false
    f.puts "#TRANS #{konto} {} #{(rate * value).round(2)}" if (value != 0.0) || force
  end

  def trans2 f, rate, konto, moms, value
    rate = rate / (1.0+rate)
    trans f, 1-rate, konto, value
    trans f,  rate, moms,  value
  end

  def report_header row,f3
    res = ''
    (0...COLS).each do |i|
      res += @keys[i][0..9].rjust(COL_WIDTH)
    end
    f3.puts res
  end

  def report_line row,f3
    res = ''
    (0...COLS).each do |i|
      res += row[i].rjust(COL_WIDTH)
      if i>=4
        @sum[i] += row[i].gsub(',','.').to_f
      end
    end
    f3.puts res
  end

  def report_footer f3
    f3.puts ''
    res = ''
    (0...COLS).each do |i|
      if @sum[i]==0
        res += ''.rjust(11)
      else
        res += ('%.2f' % @sum[i]).rjust(COL_WIDTH)
      end
    end
    f3.puts res
  end

  File.open(file2, 'w') do |f|
    File.open(file3, 'w') do |f3|
      f.puts '#FLAGGA 0'
      f.puts '#FORMAT PC8'
      f.puts '#SIETYP 4'
      f.puts '#PROGRAM "Push & Pop Data AB" ' + "#{VERSION}"
      f.puts "#GEN #{Time.now.strftime('%Y%m%d')}"
      f3.puts file1
      f3.puts ''
      report_header @keys,f3
      @data.each_with_index do |row,i|
        f.puts
        f.puts "#VER 'F' '' #{row[DATUM].gsub('-','')} '#{row[PASSNR]}'".gsub("'",'"')
        f.puts '{'
        if row[PERSONTRSP].to_f==0.0 && row[BUD].to_f==0.0 && row[ATT_REDOVISA].to_f==0.0 && row[UTLAGG].to_f==0.0 && row[KREDITER].to_f==0.0
          trans  f, 1, 3213, -row[UTLAGG].to_f, true
          trans  f, 1, 1910, row[UTLAGG].to_f, true
        else
          trans2 f, 0.06, 3213, 2630, -row[PERSONTRSP].to_f
          trans2 f, 0.25, 3211, 2610, -row[BUD].to_f
          trans  f, 1, 3290, -row[UTRIKES].to_f
          trans  f, 1, 1910, row[ATT_REDOVISA].to_f
          trans  f, 1, 1910, row[UTLAGG].to_f
          trans  f, 1, 1581, row[KREDITER].to_f

          summa = -row[PERSONTRSP].to_f
          summa += -row[BUD].to_f
          summa += -row[UTRIKES].to_f
          summa += row[ATT_REDOVISA].to_f
          summa += row[UTLAGG].to_f
          summa += row[KREDITER].to_f
          puts "#{row[PASSNR]} Obalans! #{summa}" if summa != 0.0
        end
        f.puts '}'
        report_line row, f3
      end
      report_footer f3
    end
  end

end

def safe_mkdir name
  begin
    Dir.mkdir(name)
  rescue
  end
end

def execute_bolag bolag
  safe_mkdir(bolag + 'ut\\')
  safe_mkdir(bolag + 'rapport\\')
  safe_mkdir(bolag + 'klara\\')

  Dir.entries(bolag).each do |f|
    if f.index('pass') == 0
      file1 = bolag + f
      file2 = bolag + "ut\\" + f.gsub('.txt', '.si')
      file3 = bolag + "rapport\\" + f.gsub('.txt', '.rpt')
      file4 = bolag + "klara\\" + f
      process_one_file file1, file2, file3
      File.rename file1, file4
    end
  end
end

#def read_fnr_fnamn(file)
#  lines = []
#  File.open(file, 'r') do |f|
#    lines = f.readlines
#  end
#  res = {}
#  lines.each do |line|
#    arr = line.chomp.split(';')
#    res[arr[0]] = arr[1]
#  end
#  res
#end

# gå igenom alla bolag
def execute
  Dir['*/'].each do |dir|
    execute_bolag dir
  end
end

execute