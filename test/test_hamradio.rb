require 'helper'

class TestHamradio < Test::Unit::TestCase

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

#  should "encode gridsquare invalid string" do
#    h = HamRadio.new
#    grid = h.grid_encode('over there')
#    assert_equal(nil, grid)
#  end

#  should "encode gridsquare invalid number" do
#    h = HamRadio.new
#    grid = h.grid_encode(1234567890)
#    assert_equal(nil, grid)
#  end

#  should "encode gridsquare invalid randomness" do
#    h = HamRadio.new
#    grid = h.grid_encode(Random.rand(1000))
#    assert_equal(nil, grid)
#  end

#  should "callsign lookup" do
#    h = HamRadio.new
#    grid = h.lookup_callsign('w5isp')
#    w5isp = {"callsign"=>"W5ISP", "city"=>"BLUE RIDGE", "country"=>nil, "created_at"=>"2011-06-19T23:19:47Z", "dob"=>nil, "effective"=>"2011-04-30", "expiration"=>"2021-04-30", "first_name"=>"GRAHAM D", "gridsquare"=>"\u0004\f13\u0012\u0005", "id"=>585745, "last_name"=>"MCINTIRE", "lat"=>"33.245919", "license_class"=>"G", "long"=>"-96.426614", "precision"=>"address", "previous_call"=>"", "previous_class"=>nil, "state"=>"TX", "street"=>"11411 CR 571", "updated_at"=>"2011-06-23T20:41:47Z", "zip"=>"75424"}
#    assert_equal(w5isp, grid)
#  end

#  should "encode gridsquare invalid randomness" do
#    h = HamRadio.new
#    grid = h.grid_encode(Random.rand(1000))
#    assert_equal(nil, grid)
#  end

  should "Valid gridsquare check EM13" do
    h = HamRadio.new
    grid = h.valid_gridsquare('EM13')
    assert_equal(true, grid)
  end

  should "Valid gridsquare check EM13sf" do
    h = HamRadio.new
    grid = h.valid_gridsquare('EM13sf')
    assert_equal(true, grid)
  end

  should "Valid gridsquare check Em13sF" do
    h = HamRadio.new
    grid = h.valid_gridsquare('Em13sF')
    assert_equal(true, grid)
  end

  should "Invalid gridsquare check EM" do
    h = HamRadio.new
    grid = h.valid_gridsquare('EM')
    assert_equal(false, grid)
  end

  should "Invalid gridsquare check EM1" do
    h = HamRadio.new
    grid = h.valid_gridsquare('EM1')
    assert_equal(false, grid)
  end

  should "Invalid gridsquare check 13" do
    h = HamRadio.new
    grid = h.valid_gridsquare('13')
    assert_equal(false, grid)
  end

  should "Invalid gridsquare check EM131" do
    h = HamRadio.new
    grid = h.valid_gridsquare('EM131')
    assert_equal(false, grid)
  end

end
