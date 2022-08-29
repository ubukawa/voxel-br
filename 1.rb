# for reprojection. (actually it is not needed)
require './constants'
require 'yaml'
require 'json'

basename = ENV['BASENAME']
src_path = "#{TMP_DIR}/#{basename}.las"
dst_path = "#{TMP_DIR}/#{basename}-3857.las"

pipeline = <<-EOS
pipeline: 
  - 
    filename: #{src_path}
    type: readers.las
    spatialreference: "EPSG:3857" 
  -
    type: writers.las
    filename: #{dst_path}
EOS

# Use the following if reprojection is needed.
=begin
pipeline = <<-EOS
pipeline: 
  - 
    filename: #{src_path}
    type: readers.las
    spatialreference: "EPSG:3857" #modify it if it is not in webmercator.
  -
    type: filters.reprojection
    out_srs: "EPSG:3857"
  -
    type: writers.las
    filename: #{dst_path}
EOS
=end

print JSON.dump(YAML.load(pipeline))