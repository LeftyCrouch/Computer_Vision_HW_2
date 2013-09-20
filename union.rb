class Union
  attr_accessor :parent_array
  def initialize(max_label_value)
    @parent_array = Array.new.fill(0,0..30)
  end

  def find(index, parent_array)
    i = index
    while parent_array[i] != 0
      i = parent_array[i]
    end
    return i
  end

  def union(x, y, parent_array)
    i = find(x, parent_array)
    k = find(y, parent_array)
    if i != k
      parent_array[k] = i
    end
    return parent_array
  end

  def union_neighbors(new_label, neighbors_array, parent_array)
    for i in neighbors_array do
      if i != new_label
        union(i, new_label, parent_array)
      end
    end
    return parent_array
  end

end
