require 'rails_helper'

RSpec.describe "lines/show", type: :view do
  before(:each) do
    @line = assign(:line, Line.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
