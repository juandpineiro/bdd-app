require 'rails_helper'

RSpec.describe "books/new", type: :view do
  before(:each) do
    assign(:book, Book.new(
      :user => nil,
      :name => "MyString",
      :author => "MyString"
    ))
  end

  it "renders new book form" do
    render

    assert_select "form[action=?][method=?]", books_path, "post" do

      assert_select "input[name=?]", "book[user_id]"

      assert_select "input[name=?]", "book[name]"

      assert_select "input[name=?]", "book[author]"
    end
  end
end
