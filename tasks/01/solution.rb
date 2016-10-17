def convert 
  {
    'C' => {
      'K' => -> (t) { t + 273.15 },
      'F' => -> (t) { (t * 9 / 5.0) + 32 },
    },
    'K' => {
      'C' => -> (t) { t - 273.15 },
      'F' => -> (t) { (t - 273.15) * 9 / 5.0 + 32 },
    },
    'F' => {
      'K' => -> (t) { (t - 32) * 5 / 9.0 + 273.15 },
      'C' => -> (t) { (t - 32) * 5 / 9.0 },
    },
  }
end

def substance_temperatures
  {
    'water' => [0, 100],
    'ethanol' => [-114, 78.37],
    'gold' => [1064, 2700],
    'silver' => [961.8, 2162],
    'copper' => [1085, 2567],
  } 
end

def convert_between_temperature_units(temp, from, to)
  if from == to
    temp
  else
    convert[from][to].call temp
  end
end

def melting_point_of_substance(substance, unit)
  convert_between_temperature_units(substance_temperatures[substance][0], 'C', unit)
end

def boiling_point_of_substance(substance, unit)
  convert_between_temperature_units(substance_temperatures[substance][1], 'C', unit)
end