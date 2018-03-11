require 'rails_helper'

RSpec.describe "microposts/show", type: :view do
  before(:each) do
    @micropost = assign(:micropost, Micropost.create!(
      :content => "Content",
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/2/)
  end
end
