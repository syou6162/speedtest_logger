require "date"
require "json"
require "pp"

def parse_download input
  input.split("\n")[1].split(" ")[1].to_f
end

def parse_upload input
  input.split("\n")[2].split(" ")[1].to_f
end

index = "speedtest"
type = "log"

# puts `curl -XDELETE "http://localhost:9200/#{index}"`
# puts `curl -XPUT "localhost:9200/#{index}" -d '{
#   "mappings": {
#     "#{type}": {
#       "properties": {
#         "time": { "type": "date", "format": "yyyy-MM-dd HH:mm:ss Z" }
#       }
#     }
#   }
# }'`

input = ""

STDIN.each{|line|
  input += line
}

time = Time.now.strftime("%Y-%m-%d %H:%M:%S %z")
result = {:time => time,
          :download => parse_download(input),
          :upload => parse_upload(input)}

puts "{ \"index\" : { \"_index\" : \"#{index}\", \"_type\" : \"#{type}\", \"_id\" : \"#{time}\"} }"
puts result.to_json
