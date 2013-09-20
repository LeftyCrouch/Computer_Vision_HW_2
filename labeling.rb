class Labeling
  attr_accessor :row_max, :col_max, :old_array, :next_label, :final_array, :parent_array
  def initialize(row_max, col_max, old_array)
    @union = Union.new(30)
    @row_max = row_max
    @col_max = col_max
    @old_array = old_array
    @next_label = 0
  end

  def fill_arrays(row, col)
    @final_array = Array.new(row) {Array.new(col) {0}}
  end

  def determine_label(neighbors_array)
    neighbors_array.reject! { |x| x == 0 }
    if neighbors_array.empty?
      increment_next_label
      @next_label
    else
      neighbors_array.min
    end
  end

  def increment_next_label
    @next_label += 1
  end

  def assign_label(new_label, row, col)
    @final_array[row][col] = new_label
  end

  def fix_new_labels(row, col, parent)
     if old_array[row][col] == 1
       @final_array[row][col] = @union.find(@final_array[row][col], parent)
     end
  end

end
