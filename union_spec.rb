require './union'

describe Union do
  let(:u){Union.new(30)}

  it "initializes the parent array" do
    array = Array.new.fill(0,0..30)
    u.parent_array.should eq array
  end

  it "finds the parent of the index value" do
    parent = [0,0,1,2,0,4,0,0]
    value = u.find(3,parent)
    value.should eq 1
    value = u.find(5,parent)
    value.should eq 4
    value = u.find(6,parent)
    value.should eq 6
    value = u.find(7,parent)
    value.should eq 7
    value = u.find(1,parent)
    value.should eq 1
  end

  it "connects two parents in union" do
    parent = [0,0,1,2,0,4,0,0]
    parent_after = [0,0,1,2,1,4,0,0]
    u.union(3,5,parent).should eq parent_after
    parent = [0,0,1,2,0,4,0,0]
    parent_after = [0,0,1,2,0,4,0,6]
    u.union(6,7,parent).should eq parent_after
  end

  it "takes array and unions values inside it" do
    new_label = 3
    neighbors_array = [0,0,1,3]
    parent_array = [0,0,0,0]
    parent_after = [0,0,0,1]
    u.union_neighbors(new_label, neighbors_array, parent_array).should eq parent_after
  end
end
