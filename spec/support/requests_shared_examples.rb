shared_examples_for "an authenticated request" do
  it 'is not unauthorized by default' do
    do_request
    response.status.should_not == 401
  end

  context 'with an invalid user' do
    before { http_login(User.last.email, 'invalid') }

    it 'is unauthorized' do
      do_request
      response.status.should == 401
    end
  end
end

shared_examples_for "a request that validates the company" do
  it 'is not unauthorized by default' do
    do_request
    response.status.should_not == 406
  end

  context 'without company' do
    before { Company.delete_all }

    it 'is not acceptable' do
      do_request
      response.status.should == 406
    end
  end
end
