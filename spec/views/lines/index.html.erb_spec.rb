require 'rails_helper'

RSpec.describe "lines/index", type: :view do
  before(:each) do
    assign(:lines, [
      Line.create!(),
      Line.create!()
    ])
  end

  it "renders a list of lines" do
    render
  end
end
