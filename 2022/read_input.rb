def read_input (file_name, strip = true)
  lines = Array.new

  File.readlines(file_name).each do |line|
    if strip then
      lines.push(line.strip!)
    else 
      lines.push(line)
    end
  end
end
