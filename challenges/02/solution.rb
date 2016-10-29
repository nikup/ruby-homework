def ordinalize(number)
  suffix =
    case number.to_s[-1].to_i
    when 1 then 'st'
    when 2 then 'nd'
    when 3 then 'rd'
    else 'th'
    end

  suffix = 'th' if number.to_s[-2].to_i == 1
  number.to_s + suffix
end
