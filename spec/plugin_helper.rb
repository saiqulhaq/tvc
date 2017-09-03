$LOAD_PATH.unshift File.expand_path('./../../lib', __FILE__)
require 'visitors_counter'

Dir[Rails.root.join("plugins/visitors_counter/spec/**/*_spec.rb")].each do |f|
  require(f)
end

