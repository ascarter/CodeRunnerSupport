require 'rake'
require 'fileutils'

sources = Rake::FileList["Grammars/*.plist", "Languages/*.crLanguage"]
target = File.expand_path("~/Library/Application Support/CodeRunner")

sources.each do |s|
  dest = File.join(target, s)
  file dest => s do
    FileUtils.cp_r s, dest, :verbose => true
  end
  
  task :install => [dest]
end

desc "Install"
task :install

desc "Uninstall"
task :uninstall do
  sources.each { |s| FileUtils.rm_r(File.join(target, s)) }
end

task :default => :install
