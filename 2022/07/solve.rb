require_relative '../read_input'

module Day06

  def build_up(lines)
    root = nil
    path = []

    lines.each do |line|
      if line.start_with?('$ cd') then
        directory = line.delete_prefix('$ cd ')
        if directory == ".." then
          path.pop()
        elsif root == nil && directory == '/' then
          root = File.new(directory)
          path.push(root)
        else
          file = path.last().getFile(directory)
          if file == nil then
            file = File.new(directory)
            path.last().addFile(file)
          end
          path.push(file)
        end
      elsif !line.start_with?('$ ls') then
        size, name = line.split(" ")
        file = File.new(name, size.to_i)
        path.last().addFile(file)
      end
    end

    return root
  end

  def solve1(filename)
    lines = read_input(__dir__ + "/" + filename)

    root = build_up(lines)

    return root.measure_directories_with_max_100000
  end

  def solve2(filename)
    lines = read_input(__dir__ + "/" + filename)

    root = build_up(lines)

    free_space = 70000000 - root.get_size
    space_to_be_freed = 30000000 - free_space

    potential_dirs = root.find_directories_over(space_to_be_freed)
    sizes = potential_dirs.map { |file| file.get_size }
    return sizes.min
  end
end

class File 
  def initialize(name, size = 0)
    @name = name
    @size = size
    @files = []
  end

  attr_accessor :name

  def addFile(file)
    @files.push(file)
  end

  def getFile(name)
    @files.find {|file| file.name == name}
  end

  def directory? 
    !@files.empty?
  end

  def find_directories_over(size)
    list = []
    if self.directory? && self.get_size >= size then
      list << self
    end

    list << @files.map {|file| file.find_directories_over(size)}
    return list.flatten
  end
  
  def measure_directories_with_max_100000
    count = 0
    if self.directory? && self.get_size <= 100000 then
      count += self.get_size
    end
    count += @files.reduce(0) {|sum, file| sum += file.measure_directories_with_max_100000 }
  end

  def get_size
    if @size != 0 then
      return @size
    else
      return @files.reduce(0) {|sum, file| sum += file.get_size}
    end
  end
end

include Day06
puts solve1('input.txt')
puts solve2('input.txt')