class HamRadio

  require 'open-uri'
  require 'xmlsimple'

  def get_session
     begin
         hamqth_xml  = open("http://www.hamqth.com/xml.php?u=#{@call}&p=#{@pass}") 
         hamqth_data = XmlSimple.xml_in(hamqth_xml)
         session_data = hamqth_data['session'][0]
         if not session_data['error'].nil?
             raise Exception, hamqth_data['session'][0]['error'][0]
         end
         if session_data['session_id'].nil?
             raise Exception, "Unknown error (no details; sorry)"
         end
         @session = hamqth_data['session'][0]['session_id'][0]
     rescue Exception => e
         puts "Could not initialize HamQTH session - continuing"
         if not e.nil?
             puts "There was an error: #{e.to_s}"
         end
         @session = nil
     end
  end

  def initialize(call=nil, pass=nil)
     @call = call
     @pass = pass
     @session = nil
     if not @call.nil?
         if not @pass.nil?
             get_session()
         end
     end
  end

  def parse_search(data)
      station_data = {}
      data.keys.each do |key|
          value = data[key][0]
          station_data[key.to_sym] = value
      end
      station_data[:callsign].upcase!
      station_data
  end
  
  def grid_encode(dms)

    # return nil if this isn't a valid gridsquare
    return nil if self.valid_gridsquare(dms) == nil
    grid = ''

    lat = dms[0].to_f+90
    lon = dms[1].to_f+180

    v = (lon/20).to_i
    lon -= (v*20)
    grid += ((?A.ord + v).chr).to_s # first letter

    v = (lat/10).to_i
    lat -= (v*10)
    grid += ((?A.ord + v).chr).to_s # second letter

    p3 = (lon/2).to_i
    grid += p3.to_s # third number
    p4 = (lat).to_i
    grid += p4.to_s # fourth number

    lon -= p3*2
    lat -= p4
    p3 = (?0.ord + p3.to_i).chr
    p4 = (?0.ord + p4).chr
    p5 = (12.ord * lon).to_i
    p6 = (24.ord * lat).to_i

    grid += ((?a.ord + p5).chr).to_s # fifth letter
    grid += ((?a.ord + p6).chr).to_s # sixth letter

  end

  def grid_decode(gridsquare)
    gridsquare += 'MM' if gridsquare.size == 4

    a = gridsquare[0].ord - 'A'.ord
    b = gridsquare[1].ord - 'A'.ord
    c = gridsquare[2].ord - '0'.ord
    d = gridsquare[3].ord - '0'.ord
    e = gridsquare[4].upcase.ord - 'A'.ord
    f = gridsquare[5].upcase.ord - 'A'.ord
    lon = (a*20) + (c*2) + ((e+0.5)/12) - 180
    lat = (b*10) + d + ((f+0.5)/24) - 90
    [lat,lon]
  end

  def valid_gridsquare(grid)
    (grid =~ /[a-z][a-z]\d\d[a-z]*/i) != nil
  end

  def get_lookup_data(call)
     begin
         return XmlSimple.xml_in(open("http://www.hamqth.com/xml.php?id=#{@session}&callsign=#{call}&prg=rubyHamRadioGem"))
     rescue Exception => e
         raise Exception, "Error getting callsign data: #{e.to_s}"
     end
  end
  
  def get_dxcc_data(call)
     begin
        return XmlSimple.xml_in(open("http://www.hamqth.com/dxcc.php?callsign=#{call}"))
     rescue
        raise Exception, "Error getting DXCC data: #{e.to_s}"
     end
  end

  def lookup_callsign(call)
     query = nil
     begin
         query = get_lookup_data(call)
         if not query['session'].nil?
             error = query['session'][0]['error'][0]
             if error.match(/not exist or expired/)
                 get_session()
                 query = get_lookup_data(call)
             else
                 raise Exception, error
             end
         end
         parse_search(query['search'][0])
     rescue Exception => e
         puts "Could not get callsign data for #{call}"
         puts "There was an error: #{e.to_s}"
         return nil
     end
  end

  def lookup_dxcc(call)
      query = nil
      begin
          query = get_dxcc_data(call)
          parse_search(query['dxcc'][0])
      rescue Exception => e
          puts "Could not get DXCC data for #{call}"
          puts "There was an error: #{e.to_s}"
          return nil
      end
  end

  def valid_callsign(call)
    (call =~ /^([BFGIKMNTW]|[A-Z0-9]{2})[0-9][A-Z0-9]{0,3}[A-Z]$/i) != nil
  end

end
