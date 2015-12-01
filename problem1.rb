source1 = File.open('pipe_delimited.txt', 'r')
source2 = File.open('space_delimited.txt', 'r')
source3 = File.open('coma_delimited.txt', 'r')

sex = {'F' => 'Female',
     'M' => 'Male',
     'Male' => 'Male',
     'Female'=> 'Female'
}

data = []
source1.each_line do |line|
  splitted =  line.split('|').map{|x| x.strip}
  break if splitted.size == 1 
  time = splitted[-1].split('-').reverse.map{|x| x.to_i}
  data << {s_name: splitted[0], f_name: splitted[1], sex: sex[splitted[3]],date: Time.new(time[0], time[-1], time[1]), color: splitted[4]}
end
source2.each_line do |line|
  splitted =  line.split(' ').map{|x| x.strip}  
  break if splitted.size <= 1   
  time = splitted[-2].split('-').reverse
  data << {s_name: splitted[0], f_name: splitted[1], sex: sex[splitted[3]], date: Time.new(time[0], time[-1], time[1]), color: splitted[-1]}
end
source3.each_line do |line|
  splitted =  line.split(', ').map{|x| x.strip}  
  break if splitted.size == 1   
  time = splitted[-1].split('/').reverse
  data << {s_name: splitted[0], f_name: splitted[1], sex: sex[splitted[2]], date: Time.new(time[0], time[-1], time[1]), color: splitted[-2]}
end

def data_to_s(hash)
  "#{hash[:s_name]} #{hash[:f_name]} #{hash[:sex]} #{hash[:date].strftime("%m/%d/%Y")} #{hash[:color]}"
end

output = File.open('output.txt', 'w')
output.puts "Output 1:"
data.sort_by!{|x| [x[:sex] , x[:s_name]]}.each do |x|
  output.puts data_to_s(x)
end
output.puts "\nOutput 2:"
data.sort_by{|x| [x[:date], x[:s_name]]}.each do |x|
  output.puts data_to_s(x)
end
output.puts "\nOutput 3:"
data.sort_by{|x| x[:s_name]}.reverse.each do |x|
  output.puts data_to_s(x)
end



