require 'rails_helper'

RSpec.describe "lines/new", type: :view do
  before(:each) do
    assign(:line, Line.new())
  end

  it "renders new line form" do
    render

    assert_select "form[action=?][method=?]", lines_path, "post" do
    end
  end
end
