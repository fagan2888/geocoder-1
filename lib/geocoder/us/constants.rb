require 'set'

module Geocoder
end

module Geocoder::US
  class Map < Hash
    attr_accessor :partial
    def self.[] (*items)
      hash = super(*items)
      hash.build_partial
      hash.keys.each {|k| hash[k.downcase] = hash.fetch(k)}
      hash.values.each {|v| hash[v.downcase] = v}
      hash.freeze
    end
    def build_partial
      @partial = Set.new()
      [keys, values].flatten.each {|item|
        tokens = item.downcase.split
        tokens.each_index {|i|
          @partial << tokens[0..i].join(" ")
        }
      }
    end
    def partial? (key)
      @partial.member? key.downcase
    end 
    def key? (key)
      super(key.downcase)
    end
    def [] (key)
      super(key.downcase)
    end
  end

  # 2008 TIGER/Line technical documentation Appendix C
  Directional = Map[
    "North"	=> "N",
    "South"	=> "S",
    "East"	=> "E",
    "West"	=> "W",
    "Northeast"	=> "NE",
    "Northwest"	=> "NW",
    "Southeast"	=> "SE",
    "Southwest"	=> "SW",
    "Norte"	=> "N",
    "Sur"	=> "S",
    "Este"	=> "E",
    "Oeste"	=> "O",
    "Noreste"	=> "NE",
    "Noroeste"	=> "NO",
    "Sudeste"	=> "SE",
    "Sudoeste"	=> "SO"
  ]

  # 2008 TIGER/Line technical documentation Appendix D
  Prefix_Qualifier = Map[
    "Alternate"	=> "Alt",
    "Business"	=> "Bus",
    "Bypass"	=> "Byp",
    "Extended"	=> "Exd",
    "Historic"	=> "Hst",
    "Loop"	=> "Lp",
    "Old"	=> "Old",
    "Private"	=> "Pvt",
    "Public"	=> "Pub",
    "Spur"	=> "Spr",
  ]

  # 2008 TIGER/Line technical documentation Appendix D
  Suffix_Qualifier = Map[
    "Access"	=> "Acc",
    "Alternate"	=> "Alt",
    "Business"	=> "Bus",
    "Bypass"	=> "Byp",
    "Connector"	=> "Con",
    "Extended"	=> "Exd",
    "Extension"	=> "Exn",
    "Loop"	=> "Lp",
    "Private"	=> "Pvt",
    "Public"	=> "Pub",
    "Scenic"	=> "Scn",
    "Spur"	=> "Spr",
    "Ramp"	=> "Rmp",
    "Underpass"	=> "Unp",
    "Overpass"	=> "Ovp",
  ]

  # subset of 2008 TIGER/Line technical documentation Appendix E
  # extracted from TIGER/Line database import
  Prefix_Canonical = {
    "Arcade"                            => "Arc",
    "Autopista"                         => "Autopista",
    "Avenida"                           => "Ave",
    "Avenue"                            => "Ave",
    "Boulevard"                         => "Blvd",
    "Bulevar"                           => "Bulevar",
    "Bureau of Indian Affairs Highway"  => "BIA Hwy",
    "Bureau of Indian Affairs Road"     => "BIA Rd",
    "Bureau of Indian Affairs Route"    => "BIA Rte",
    "Bureau of Land Management Road"    => "BLM Rd",
    "Bypass"                            => "Byp",
    "Calle"                             => "Cll",
    "Calleja"                           => "Calleja",
    "Callejón"                          => "Callejón",
    "Caminito"                          => "Cmt",
    "Camino"                            => "Cam",
    "Carretera"                         => "Carr",
    "Cerrada"                           => "Cer",
    "Círculo"                           => "Cír",
    "Commons"                           => "Cmns",
    "Corte"                             => "Corte",
    "County Highway"                    => "Co Hwy",
    "County Lane"                       => "Co Ln",
    "County Road"                       => "Co Rd",
    "County Route"                      => "Co Rte",
    "County State Aid Highway"          => "Co St Aid Hwy",
    "County Trunk Highway"              => "Co Trunk Hwy",
    "County Trunk Road"                 => "Co Trunk Rd",
    "Court"                             => "Ct",
    "Delta Road"                        => "Delta Rd",
    "District of Columbia Highway"      => "DC Hwy",
    "Driveway"                          => "Driveway",
    "Entrada"                           => "Ent",
    "Expreso"                           => "Expreso",
    "Expressway"                        => "Expy",
    "Farm Road"                         => "Farm Rd",
    "Farm-to-Market Road"               => "FM",
    "Fire Control Road"                 => "Fire Cntrl Rd",
    "Fire District Road"                => "Fire Dist Rd",
    "Fire Lane"                         => "Fire Ln",
    "Fire Road"                         => "Fire Rd",
    "Fire Route"                        => "Fire Rte",
    "Fire Trail"                        => "Fire Trl",
    "Forest Highway"                    => "Forest Hwy",
    "Forest Road"                       => "Forest Rd",
    "Forest Route"                      => "Forest Rte",
    "Forest Service Road"               => "FS Rd",
    "Highway"                           => "Hwy",
    "Indian Route"                      => "Indian Rte",
    "Indian Service Route"              => "Indian Svc Rte",
    "Interstate Highway"                => "I-",
    "Lane"                              => "Ln",
    "Logging Road"                      => "Logging Rd",
    "Loop"                              => "Loop",
    "National Forest Development Road"  => "Nat For Dev Rd",
    "Navajo Service Route"              => "Navajo Svc Rte",
    "Parish Road"                       => "Parish Rd",
    "Pasaje"                            => "Pasaje",
    "Paseo"                             => "Pso",
    "Passage"                           => "Psge",
    "Placita"                           => "Pla",
    "Plaza"                             => "Plz",
    "Point"                             => "Pt",
    "Puente"                            => "Puente",
    "Ranch Road"                        => "Ranch Rd",
    "Ranch to Market Road"              => "RM",
    "Reservation Highway"               => "Resvn Hwy",
    "Road"                              => "Rd",
    "Route"                             => "Rte",
    "Row"                               => "Row",
    "Rue"                               => "Rue",
    "Ruta"                              => "Ruta",
    "Sector"                            => "Sec",
    "Sendero"                           => "Sendero",
    "Service Road"                      => "Svc Rd",
    "Skyway"                            => "Skwy",
    "Square"                            => "Sq",
    "State Forest Service Road"         => "St FS Rd",
    "State Highway"                     => "State Hwy",
    "State Loop"                        => "State Loop",
    "State Road"                        => "State Rd",
    "State Route"                       => "State Rte",
    "State Spur"                        => "State Spur",
    "State Trunk Highway"               => "St Trunk Hwy",
    "Terrace"                           => "Ter",
    "Town Highway"                      => "Town Hwy",
    "Town Road"                         => "Town Rd",
    "Township Highway"                  => "Twp Hwy",
    "Township Road"                     => "Twp Rd",
    "Trail"                             => "Trl",
    "Tribal Road"                       => "Tribal Rd",
    "Tunnel"                            => "Tunl",
    "US Forest Service Highway"         => "USFS Hwy",
    "US Forest Service Road"            => "USFS Rd",
    "US Highway"                        => "US Hwy",
    "US Route"                          => "US Rte",
    "Vereda"                            => "Ver",
    "Via"                               => "Via",
    "Vista"                             => "Vis",
  }

  # merged from http://www.usps.com/ncsc/lookups/abbr_suffix.txt
  Prefix_Alternate = {
    "Av"			=> "Ave",
    "Aven"			=> "Ave",
    "Avenu"			=> "Ave",
    "Avenue"			=> "Ave",
    "Avn"			=> "Ave",
    "Avnue"			=> "Ave",
    "Boul"			=> "Blvd",
    "Boulv"			=> "Blvd",
    "Bypa"			=> "Byp",
    "Bypas"			=> "Byp",
    "Byps"			=> "Byp",
    "Crt"			=> "Ct",
    "Exp"			=> "Expy",
    "Expr"			=> "Expy",
    "Express"			=> "Expy",
    "Expw"			=> "Expy",
    "Highwy"			=> "Hwy",
    "Hiway"			=> "Hwy",
    "Hiwy"			=> "Hwy",
    "Hway"			=> "Hwy",
    "La"			=> "Ln",
    "Lanes"			=> "Ln",
    "Loops"			=> "Loop",
    "Plza"			=> "Plz",
    "Sqr"			=> "Sq",
    "Sqre"			=> "Sq",
    "Squ"			=> "Sq",
    "Terr"			=> "Ter",
    "Tr"			=> "Trl",
    "Trails"			=> "Trl",
    "Trls"			=> "Trl",
    "Tunel"			=> "Tunl",
    "Tunls"			=> "Tunl",
    "Tunnels"			=> "Tunl",
    "Tunnl"			=> "Tunl",
    "Vdct"			=> "Via",
    "Viadct"			=> "Via",
    "Viaduct"			=> "Via",
    "Vist"			=> "Vis",
    "Vst"			=> "Vis",
    "Vsta"			=> "Vis"
  }
  
  # Canonical abbreviations + USPS accepted alternates
  Prefix_Type = Map[ Prefix_Canonical.merge Prefix_Alternate ]

  # subset of 2008 TIGER/Line technical documentation Appendix E
  # extracted from TIGER/Line database import
  Suffix_Canonical = {
    "Alley"                             => "Aly",
    "Arcade"                            => "Arc",
    "Avenida"                           => "Ave",
    "Avenue"                            => "Ave",
    "Beltway"                           => "Beltway",
    "Boulevard"                         => "Blvd",
    "Bridge"                            => "Brg",
    "Bypass"                            => "Byp",
    "Causeway"                          => "Cswy",
    "Circle"                            => "Cir",
    "Common"                            => "Cmn",
    "Commons"                           => "Cmns",
    "Corners"                           => "Cors",
    "Court"                             => "Ct",
    "Courts"                            => "Cts",
    "Crescent"                          => "Cres",
    "Crest"                             => "Crst",
    "Crossing"                          => "Xing",
    "Cutoff"                            => "Cutoff",
    "Drive"                             => "Dr",
    "Driveway"                          => "Driveway",
    "Esplanade"                         => "Esplanade",
    "Estates"                           => "Ests",
    "Expressway"                        => "Expy",
    "Forest Highway"                    => "Forest Hwy",
    "Fork"                              => "Frk",
    "Four-Wheel Drive Trail"            => "4WD Trl",
    "Freeway"                           => "Fwy",
    "Grade"                             => "Grade",
    "Heights"                           => "Hts",
    "Highway"                           => "Hwy",
    "Jeep Trail"                        => "Jeep Trl",
    "Landing"                           => "Lndg",
    "Lane"                              => "Ln",
    "Logging Road"                      => "Logging Rd",
    "Loop"                              => "Loop",
    "Motorway"                          => "Mtwy",
    "Oval"                              => "Oval",
    "Overpass"                          => "Opas",
    "Parkway"                           => "Pkwy",
    "Pass"                              => "Pass",
    "Passage"                           => "Psge",
    "Path"                              => "Path",
    "Pike"                              => "Pike",
    "Place"                             => "Pl",
    "Plaza"                             => "Plz",
    "Point"                             => "Pt",
    "Pointe"                            => "Pointe",
    "Promenade"                         => "Promenade",
    "Railroad"                          => "RR",
    "Railway"                           => "Rlwy",
    "Ramp"                              => "Ramp",
    "River"                             => "Riv",
    "Road"                              => "Rd",
    "Roadway"                           => "Roadway",
    "Route"                             => "Rte",
    "Row"                               => "Row",
    "Rue"                               => "Rue",
    "Service Road"                      => "Svc Rd",
    "Skyway"                            => "Skwy",
    "Spur"                              => "Spur",
    "Square"                            => "Sq",
    "Stravenue"                         => "Stra",
    "Street"                            => "St",
    "Strip"                             => "Strip",
    "Terrace"                           => "Ter",
    "Thoroughfare"                      => "Thoroughfare",
    "Tollway"                           => "Tollway",
    "Trace"                             => "Trce",
    "Trafficway"                        => "Trfy",
    "Trail"                             => "Trl",
    "Trolley"                           => "Trolley",
    "Truck Trail"                       => "Truck Trl",
    "Tunnel"                            => "Tunl",
    "Turnpike"                          => "Tpke",
    "Viaduct"                           => "Viaduct",
    "View"                              => "Vw",
    "Vista"                             => "Vis",
    "Walk"                              => "Walk",
    "Walkway"                           => "Walkway",
    "Way"                               => "Way",
  }
  
  # merged from http://www.usps.com/ncsc/lookups/abbr_suffix.txt
  Suffix_Alternate = {
    "Allee"			=> "Aly",
    "Ally"			=> "Aly",
    "Av"			=> "Ave",
    "Aven"			=> "Ave",
    "Avenu"			=> "Ave",
    "Avenue"			=> "Ave",
    "Avn"			=> "Ave",
    "Avnue"			=> "Ave",
    "Boul"			=> "Blvd",
    "Boulv"			=> "Blvd",
    "Brdge"			=> "Brg",
    "Bypa"			=> "Byp",
    "Bypas"			=> "Byp",
    "Byps"			=> "Byp",
    "Causway"			=> "Cswy",
    "Circ"			=> "Cir",
    "Circl"			=> "Cir",
    "Crcl"			=> "Cir",
    "Crcle"			=> "Cir",
    "Crecent"			=> "Cres",
    "Cresent"			=> "Cres",
    "Crscnt"			=> "Cres",
    "Crsent"			=> "Cres",
    "Crsnt"			=> "Cres",
    "Crssing"			=> "Xing",
    "Crssng"			=> "Xing",
    "Crt"			=> "Ct",
    "Driv"			=> "Dr",
    "Drv"			=> "Dr",
    "Exp"			=> "Expy",
    "Expr"			=> "Expy",
    "Express"			=> "Expy",
    "Expw"			=> "Expy",
    "Freewy"			=> "Fwy",
    "Frway"			=> "Fwy",
    "Frwy"			=> "Fwy",
    "Height"			=> "Hts",
    "Hgts"			=> "Hts",
    "Highwy"			=> "Hwy",
    "Hiway"			=> "Hwy",
    "Hiwy"			=> "Hwy",
    "Ht"			=> "Hts",
    "Hway"			=> "Hwy",
    "La"			=> "Ln",
    "Lanes"			=> "Ln",
    "Lndng"			=> "Lndg",
    "Loops"			=> "Loop",
    "Ovl"			=> "Oval",
    "Parkways"			=> "Pkwy",
    "Parkwy"			=> "Pkwy",
    "Paths"			=> "Path",
    "Pikes"			=> "Pike",
    "Pkway"			=> "Pkwy",
    "Pkwys"			=> "Pkwy",
    "Pky"			=> "Pkwy",
    "Plza"			=> "Plz",
    "Rivr"			=> "Riv",
    "Rvr"			=> "Riv",
    "Spurs"			=> "Spur",
    "Sqr"			=> "Sq",
    "Sqre"			=> "Sq",
    "Squ"			=> "Sq",
    "Str"			=> "St",
    "Strav"			=> "Stra",
    "Strave"			=> "Stra",
    "Straven"			=> "Stra",
    "Stravn"			=> "Stra",
    "Strt"			=> "St",
    "Strvn"			=> "Stra",
    "Strvnue"			=> "Stra",
    "Terr"			=> "Ter",
    "Tpk"			=> "Tpke",
    "Tr"			=> "Trl",
    "Traces"			=> "Trce",
    "Trails"			=> "Trl",
    "Trls"			=> "Trl",
    "Trnpk"			=> "Tpke",
    "Trpk"			=> "Tpke",
    "Tunel"			=> "Tunl",
    "Tunls"			=> "Tunl",
    "Tunnels"			=> "Tunl",
    "Tunnl"			=> "Tunl",
    "Turnpk"			=> "Tpke",
    "Vist"			=> "Vis",
    "Vst"			=> "Vis",
    "Vsta"			=> "Vis",
    "Walks"			=> "Walk",
    "Wy"			=> "Way",
  }

  # Canonical abbreviations + USPS accepted alternates
  Suffix_Type = Map[ Suffix_Canonical.merge Suffix_Alternate ]

  # http://www.usps.com/ncsc/lookups/abbr_sud.txt
  Unit_Type = Map[
    "Apartment"	=> "Apt",
    "Basement"	=> "Bsmt",
    "Building"	=> "Bldg",
    "Department"=> "Dept",
    "Floor"	=> "Fl",
    "Front"	=> "Frnt",
    "Hangar"	=> "Hngr",
    "Lobby"	=> "Lbby",
    "Lot"	=> "Lot",
    "Lower"	=> "Lowr",
    "Office"	=> "Ofc",
    "Penthouse"	=> "Ph",
    "Pier"	=> "Pier",
    "Rear"	=> "Rear",
    "Room"	=> "Rm",
    "Side"	=> "Side",
    "Slip"	=> "Slip",
    "Space"	=> "Spc",
    "Stop"	=> "Stop",
    "Suite"	=> "Ste",
    "Trailer"	=> "Trlr",
    "Unit"	=> "Unit",
    "Upper"	=> "Uppr",
  ]

  State = Map[
    "Alabama"		=> "AL",
    "Alaska"		=> "AK",
    "American Samoa"	=> "AS",
    "Arizona"		=> "AZ",
    "Arkansas"		=> "AR",
    "California"	=> "CA",
    "Colorado"		=> "CO",
    "Connecticut"	=> "CT",
    "Delaware"		=> "DE",
    "District of Columbia" => "DC",
    "Federated States of Micronesia" => "FM",
    "Florida"		=> "FL",
    "Georgia"		=> "GA",
    "Guam"		=> "GU",
    "Hawaii"		=> "HI",
    "Idaho"		=> "ID",
    "Illinois"		=> "IL",
    "Indiana"		=> "IN",
    "Iowa"		=> "IA",
    "Kansas"		=> "KS",
    "Kentucky"		=> "KY",
    "Louisiana"		=> "LA",
    "Maine"		=> "ME",
    "Marshall Islands"	=> "MH",
    "Maryland"		=> "MD",
    "Massachusetts"	=> "MA",
    "Michigan"		=> "MI",
    "Minnesota"		=> "MN",
    "Mississippi"	=> "MS",
    "Missouri"		=> "MO",
    "Montana"		=> "MT",
    "Nebraska"		=> "NE",
    "Nevada"		=> "NV",
    "New Hampshire"	=> "NH",
    "New Jersey"	=> "NJ",
    "New Mexico"	=> "NM",
    "New York"		=> "NY",
    "North Carolina"	=> "NC",
    "North Dakota"	=> "ND",
    "Northern Mariana Islands"	=> "MP",
    "Ohio"		=> "OH",
    "Oklahoma"		=> "OK",
    "Oregon"		=> "OR",
    "Palau"		=> "PW",
    "Pennsylvania"	=> "PA",
    "Puerto Rico"	=> "PR",
    "Rhode Island"	=> "RI",
    "South Carolina"	=> "SC",
    "South Dakota"	=> "SD",
    "Tennessee"		=> "TN",
    "Texas"		=> "TX",
    "Utah"		=> "UT",
    "Vermont"		=> "VT",
    "Virgin Islands"	=> "VI",
    "Virginia"		=> "VA",
    "Washington"	=> "WA",
    "West Virginia"	=> "WV",
    "Wisconsin"		=> "WI",
    "Wyoming"		=> "WY"
  ]
end
