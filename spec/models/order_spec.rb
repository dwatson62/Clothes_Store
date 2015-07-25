require 'rails_helper'

describe Order do

  it { is_expected.to belong_to :user }
  it { is_expected.to have_and_belong_to_many :products }

end