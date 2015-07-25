require 'rails_helper'

describe Order do

  it { is_expected.to belong_to :user }

end