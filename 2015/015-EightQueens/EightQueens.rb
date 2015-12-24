n = 8
n.times.map {|i| i}.permutation do |b|
  next if n.times.map { |i| b[i]-i }.uniq.size != n
  next if n.times.map { |i| b[i]+i }.uniq.size != n
  p b
end
