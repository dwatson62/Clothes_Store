require 'rails_helper'

describe Product do

  it { is_expected.to have_and_belong_to_many :orders }

end