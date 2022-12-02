def read_input (file_name)
  lines = Array.new

  File.readlines(file_name).each do |line|
    lines.push(line.strip!)
  end
end
