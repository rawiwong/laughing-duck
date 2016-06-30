def main input_file, output_file
  fp_in = open(input_file)
  fp_out = open(output_file, "w")

  data = fp_in.read
  data = remove_pattern(data)
  fp_out.write(data)

  fp_in.close
  fp_out.close
end

# BM = "<BEGIN-MARK>"
# EM = "<END-MARK>"
DELIMITER = "<MARK-POINT>"
def remove_pattern( input ) 
  output = input
#  output = output.gsub(/\[\d+m\w+\s*\(.+?\)/, '<TIME_POINT>')
#  output = output.gsub(/\[\d+m/, 'MY_MARK')
#  output = output.gsub(/\d+mSQL/, 'XXXXXXX')
#  output = output.gsub(/XXXXXX.+?pg_attribute.+?ORDER BY a.attnum/m, 'XXXXXX')

#  output = output.gsub(/\[1m/, BM)
#  output = output.gsub(/\[0m/, EM)
#  output = output.gsub(/#{BM}\w+\s*FROM pg_attribute\w+\s*#{EM}/m, '<DELETE-MARK>')
#  output = output.gsub(/\<BEGIN-MARK\>(?!FROM).+FROM pg_attribute.+?\<BEGIN-MARK>/m, '<DELETE-MARK>')
##################

  output = output.gsub(/(\[\d+m|\s)+.+?\(\d+(\.\d+)ms\)(\[\d+m|\s)+/, "\n"+DELIMITER)
  data_array = []
  item_no = 0
  output.split(DELIMITER).each { |s|
#    p s
    data_array << ((item_no = item_no + 1).to_s + ": \n" + s + "\n") unless s.include? "FROM pg_attribute"
  }
  output = data_array.join("")
  output
end

main "in.txt", "out.txt"
