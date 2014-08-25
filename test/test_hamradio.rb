require 'helper'
require 'base64'

class TestHamradio < Test::Unit::TestCase

   hq_call = 'RubyGemTester'
   hq_pw   =  Base64.decode64("SW52aXNpYmxlU2FuZHdpY2g=")


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

  should "look up a valid callsign" do
    h = HamRadio.new(hq_call, hq_pw)
    grid = h.lookup_callsign('w1aw')
    grid.delete(:lookups)  # necessary because this changes every time you query that callsign
    w1aw = { :callsign => "W1AW", :qth => "Newington", :country => "United States", :adif => "291", :itu => "8", :cq => "5", :grid => "FN31PR", :adr_street1 => "225 Main St", :adr_city => "Newington", :adr_zip => "06111", :adr_country => "United States", :adr_adif => "291", :us_state => "CT", :us_county => "Hartford", :lotw => "Y", :qsl => "?", :eqsl => "Y", :latitude => "41.7152046", :longitude => "-72.72690920000002", :continent => "NA", :utc_offset => "5", :registered => "N" }
    assert_equal(w1aw, grid)
  end

  should "look up valid DXCC information" do
    h = HamRadio.new
    grid = h.lookup_dxcc('w1aw')
    w1aw = {:callsign=>"W1AW", :name=>"United States", :details=>"USA - CT,MA,ME,NH,RI,VT", :continent=>"NA", :utc=>"5", :waz=>"05", :itu=>"08", :lat=>"42.38", :lng=>"-71.67", :adif=>"291"}
    assert_equal(w1aw, grid)
  end

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

#  should "Invalid gridsquare check EM131" do
#    h = HamRadio.new
#    grid = h.valid_gridsquare('EM131')
#    assert_equal(false, grid)
#  end

end
