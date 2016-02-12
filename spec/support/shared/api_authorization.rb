shared_examples_for "authenticable" do
  context 'unauthorized' do

    it "return 401 status  code" do       
      expect(response.status).to eq 401
    end

    it 'return json error' do
      expect(response.body).to include("Authorized users only.")
    end
  end
end

