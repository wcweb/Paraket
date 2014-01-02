require 'rubygems'
require 'bundler'
Bundler.require

library :robotlegs, :swc

##############################
# Configure

##
# Set USE_FCSH to true in order to use FCSH for all compile tasks.
#
# You can also set this value by calling the :fcsh task 
# manually like:
#
#   rake fcsh run
#
# These values can also be sent from the command line like:
#
#   rake run FCSH_PKG_NAME=flex3
#
# ENV['USE_FCSH']         = true
# ENV['FCSH_PKG_NAME']    = 'flex4'
# ENV['FCSH_PKG_VERSION'] = '1.0.14.pre'
# ENV['FCSH_PORT']        = 12321

def configure_mxmlc t
    # need by as not flex with static link runtime shared lib
  t.static_link_runtime_shared_libraries = true
 # t.advanced_telemetry = true
 # t.source_path << 'src'
  t.library_path << 'lib/as3corelib.swc'
  t.library_path << 'lib/awave.swc'
  t.library_path << 'lib/shineMP3_alchemy.swc'
  t.library_path << 'lib/robotlegs/robotlegs-framework-v1.5.2.swc'
  t.library_path << 'lib/KafeComponent-v1.4.1.swc'
  t.library_path << 'lib/MonsterDebugger.swc'

end

##############################
# Run

# Compile the debug swf
mxmlc "Public/Paraket.swf" do |t|
  configure_mxmlc t
  t.input = "src/Paraket.as"
  # t.static_link_runtime_shared_libraries = true
  t.debug = false
end

desc "Compile and run the swf"
flashplayer :run => "Public/Paraket.swf"



##############################
# Debug

# Compile the debug swf
mxmlc "Public/Paraket-debug.swf" do |t|
  configure_mxmlc t
  t.input = "src/Paraket.as"
  t.static_link_runtime_shared_libraries = true

  t.debug = true
end

desc "Compile and run the debug swf"
flashplayer :debug => "Public/Paraket-debug.swf"

##############################
# Test

library :asunit4

# Compile the test swf
mxmlc "Public/ParaketRunner.swf" => :asunit4 do |t|
  configure_mxmlc t
  t.input = "src/ParaketRunner.as"
  t.library_path << "lib/asunit4/AsUnit-4.2.3.pre.swc"

  t.source_path << "test"

  t.default_size = "900,550"
  t.debug = true
end

desc "Compile and run the test swf"
flashplayer :test => "Public/ParaketRunner.swf"

##############################
# SWC

compc "bin/Paraket.swc" do |t|
  t.input_class = "Paraket"
  t.static_link_runtime_shared_libraries = true
  t.source_path << 'src'
end

desc "Compile the SWC file"
task :swc => 'bin/Paraket.swc'

##############################
# DOC

desc "Generate documentation at doc/"
asdoc 'doc' do |t|
  t.doc_sources << "src"
  t.exclude_sources << "src/ParaketRunner.as"
end


task :default => :debug
