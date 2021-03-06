require 'spec_helper'

describe "rounds/edit.html.erb" do
  before(:each) do
    @round = assign(:round, stub_model(Round,
      :strokes => 1
    ))
  end

  it "renders the edit round form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => round_path(@round), :method => "post" do
      assert_select "input#round_strokes", :name => "round[strokes]"
    end
  end
end
