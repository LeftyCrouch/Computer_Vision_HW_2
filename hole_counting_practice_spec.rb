require './labeling'
require './union'

describe Labeling do
  let(:l){Labeling.new(4, 1, [[0],[0],[0],[0]])}

  it "initializes with @row_max and @col_max" do
    l.row_max.should eq 4
    l.col_max.should eq 1
    l.old_array.should eq [[0],[0],[0],[0]]
    l.next_label.should eq 0
  end

  it "creates a new array with same parameters" do
    bleh = Array.new(4) {Array.new(1) {0} }
    l.fill_arrays(4,1)
    l.final_array.should eq bleh
  end

  it "determines label based on neighbors" do
    neighbors_array = [0,0,1,2]
    label_at_point = l.determine_label(neighbors_array)
    label_at_point.should eq 1
    neighbors_array = [0,0,0,3]
    label_at_point = l.determine_label(neighbors_array)
    label_at_point.should eq 3
  end

  it "assigns the label in the new array" do
    l.fill_arrays(4,1)
    l.assign_label(1, 0, 0)
    l.final_array.should eq [[1],[0],[0],[0]]
  end

  it "runs through labeling" do
    l.old_array = [[1],[1],[0],[0]]
    l.old_array.should eq [[1],[1],[0],[0]]
    l.fill_arrays(4,1)
    l.assign_label(1,0,0)
    l.assign_label(2,1,0)
    l.final_array.should eq [[1],[2],[0],[0]]
    parent = [0,0,1]
    l.fix_new_labels(1, 0, parent)
    l.final_array.should eq [[1],[1],[0],[0]]
  end

end
