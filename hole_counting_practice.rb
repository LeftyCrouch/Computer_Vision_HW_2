#Author: Christopher Crouch
#Date: 9/19/13
#IDE: Ruby 2.0.0
#
#Implement the connected component algorithm
#using the 8-neighborhood definition

class Hole_Counting
  attr_accessor :picture, :parent_array
  def initialize
    @picture = Array.new
    @parent_array = Array.new
  end

  #read in array from file
  def read_file (length_of_row, length_of_col, file_name)
    @row_max = length_of_row
    @col_max = length_of_col
    file = File.open(file_name, 'r')
    file.each_line do |line|
      line = line.strip.split(' ').map(&:to_i)
      @picture << line
    end
    self.labeling
    self.print_array(@picture)
    puts "--------------------------------------"
    self.print_array(@final_array)
  end

  #prints array in nice format
  def print_array(array)
    @array_chosen = array
    @total_external_corners = 0
    @total_internal_corners = 0
    @current_row = 0
    while @current_row < @row_max
      @current_col = 0
      while @current_col < @col_max
        @current_corner = self.get_row
        print @current_corner
        @current_col += 1
      end
      puts ""
      @current_row += 1
    end
  end

  #helps with formating for printing
  def get_row
    current_test_corner = ""
    current_test_corner << @array_chosen[@current_row][@current_col].to_s
    return current_test_corner
  end


  def labeling
    #default index 0 to 0 to deal with nil complications
    label = 1
    @parent_array.fill(0, 0..100)
    @final_array = Array.new(@row_max) {Array.new(@col_max) {0}}
    current_row = 0
    while current_row < @row_max
      current_col = 0
      while current_col < @col_max
        if @picture[current_row][current_col] == 1
          neighbor_values = self.neighbors(current_row, current_col)
          if neighbor_values.empty? or neighbor_values.max == 0
            label_at_point = label
            label += 1
          else
            if neighbor_values.min == 0
              label_at_point = neighbor_values.max
            else
              label_at_point = neighbor_values.min
            end
          end
          @final_array[current_row][current_col] = label_at_point
          for counter in neighbor_values do
            if neighbor_values[counter] != label_at_point or neighbor_values[counter] != 0
              self.union(label_at_point, neighbor_values[0])
            end
          end
        end
        current_col += 1
      end
      current_row += 1
    end
    #second run through
    current_row = 0
    while current_row < @row_max
      current_col = 0
      while current_col < @col_max
        if @picture[current_row][current_col] == 1
          @final_array[current_row][current_col] = find(@final_array[current_row][current_col])
        end
        current_col += 1
      end
      current_row += 1
    end
  end

  def neighbors(row, col)
    neighbors = Array.new
    if row == 0 && col != 0
      neighbors << @final_array[row][col - 1]
    else
      if col == 0
        neighbors << @final_array[row - 1][col]
        neighbors << @final_array[row - 1][col + 1]
      elsif col == @col_max - 1
        neighbors << @final_array[row - 1][col - 1]
        neighbors << @final_array[row - 1][col]
        neighbors << @final_array[row][col - 1]
      else
        neighbors << @final_array[row - 1][col - 1]
        neighbors << @final_array[row - 1][col]
        neighbors << @final_array[row - 1][col + 1]
        neighbors << @final_array[row][col - 1]
      end
    end
    return neighbors
  end

  #find the root label of a set using hash
  #key is the index label
  #value is the parent
  def find(index)
    x = index
    while @parent_array[x] != 0
      x = @parent_array[x]
    end
    return x
  end

  #construct the union of two sets
  def union(x, y)
    j = find(x)
    k = find(y)
    if j != k
      @parent_array[k] = j
    end
  end

end

test = Hole_Counting.new
test.read_file(32, 32, 'input.txt')
