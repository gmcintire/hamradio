class HamRadio

  def initialize()

  end

  def grid_encode(dms)

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

  def valid_gridsquare(grid)
    (grid =~ /[a-z][a-z]\d\d/i) != nil
  end

end
