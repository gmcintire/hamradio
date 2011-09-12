require 'helper'

class TestHamradio < Test::Unit::TestCase
#  should "probably rename this file and start testing for real" do
#    flunk "hey buddy, you should probably rename this file and start testing for real"
#  end

  should "encode gridsquare culleoka" do
    h = HamRadio.new
    grid = h.grid_encode([33.113675,-96.487856])
    assert_equal('EM13sc', grid)
  end

  should "encode gridsquare altoga" do
    h = HamRadio.new
    grid = h.grid_encode([33.24941379,-96.50782389])
    assert_equal('EM13rf', grid)
  end

  should "encode gridsquare verona" do
    h = HamRadio.new
    grid = h.grid_encode([33.24617412,-96.42647853])
    assert_equal('EM13sf', grid)
  end

end
