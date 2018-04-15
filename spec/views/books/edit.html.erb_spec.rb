require 'rails_helper'

RSpec.describe "books/edit", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :user => nil,
      :name => "MyString",
      :author => "MyString"
    ))
  end

  it "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(@book), "post" do

      assert_select "input[name=?]", "book[user_id]"

      assert_select "input[name=?]", "book[name]"

      assert_select "input[name=?]", "book[author]"
    end
  end
end
