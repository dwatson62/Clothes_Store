require 'rails_helper'

describe Product do

  it { is_expected.to have_and_belong_to_many :orders }

  it 'can be created' do
    expect { Product.create }.to change { Product.count }.by 1
  end

end