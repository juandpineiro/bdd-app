require 'rails_helper'

RSpec.describe BooksController do
  
  let(:user) { instance_double(User) }

  before { log_in(user) }

  describe "GET #index" do
    let(:books) { [
      instance_double(Book),
      instance_double(Book)
    ] }

    before do
      allow(user).to receive(:books).and_return(books)

      get :index
    end

    it 'looks up all books that belong to the current user' do
      expect(assigns(:books)).to eq(books)
    end
  end

  # describe "GET #show" do
  #   it "returns a success response" do
  #     book = Book.create! valid_attributes
  #     get :show, params: {id: book.to_param}, session: valid_session
  #     expect(response).to be_success
  #   end
  # end

  # describe "GET #new" do
  #   it "returns a success response" do
  #     get :new, params: {}, session: valid_session
  #     expect(response).to be_success
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns a success response" do
  #     book = Book.create! valid_attributes
  #     get :edit, params: {id: book.to_param}, session: valid_session
  #     expect(response).to be_success
  #   end
  # end

  describe "POST #create" do
    let(:book) { FactoryBot.build_stubbed(:book) }
    let(:params) { { :name => 'Moby Dick', :author => 'Herman Melville' } }

    before do
      allow(book).to receive(:save)
      allow(user).to receive_message_chain(:books, :build).and_return(book)
    end

    context 'when the book is succesfully saved' do
      before do
        allow(book).to receive(:save).and_return(true)
        
        post :create, :params => { :book => params }
      end
      
      it 'redirects to the book show page' do
        expect(response).to redirect_to(book_path(book))
      end
      
      it 'redirects to the book show page' do
        expect(flash[:notice]).to eq('Book was successfully created.')
      end
    end
    
    context "when the book can’t be saved" do
      before do
        allow(book).to receive(:save).and_return(false)
        
        post :create, :params => { :book => params }
      end
      
      it "redirects back to the new page" do
        expect(response).to render_template(:new)
      end
    end
 
  end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested book" do
  #       book = Book.create! valid_attributes
  #       put :update, params: {id: book.to_param, book: new_attributes}, session: valid_session
  #       book.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "redirects to the book" do
  #       book = Book.create! valid_attributes
  #       put :update, params: {id: book.to_param, book: valid_attributes}, session: valid_session
  #       expect(response).to redirect_to(book)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "returns a success response (i.e. to display the 'edit' template)" do
  #       book = Book.create! valid_attributes
  #       put :update, params: {id: book.to_param, book: invalid_attributes}, session: valid_session
  #       expect(response).to be_success
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "destroys the requested book" do
  #     book = Book.create! valid_attributes
  #     expect {
  #       delete :destroy, params: {id: book.to_param}, session: valid_session
  #     }.to change(Book, :count).by(-1)
  #   end

  #   it "redirects to the books list" do
  #     book = Book.create! valid_attributes
  #     delete :destroy, params: {id: book.to_param}, session: valid_session
  #     expect(response).to redirect_to(books_url)
  #   end
  # end

end
