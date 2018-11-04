require 'rails_helper'

describe BasePresenter do

  class TestPresenter < BasePresenter
  end

  it 'allows to declare a field' do
    TestPresenter.field 'bla', label: 'BlaBla'
    expect(TestPresenter.fields).to eq [ ['bla', { label: 'BlaBla' } ] ]
  end
end
