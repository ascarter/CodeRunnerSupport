require 'rake'
require 'rake/clean'

TARGET_ROOT = File.expand_path("~/Library/Application Support/CodeRunner")
SOURCES = Rake::FileList["Grammars/*.plist", "Languages/*.crLanguage"]

desc "Uninstall"
task :uninstall => :clobber

desc "Install"
task :install

task :default => :install

# Destination directories
directory File.join(TARGET_ROOT, 'Grammars')
directory File.join(TARGET_ROOT, 'Languages')

task :install => SOURCES.pathmap(File.join(TARGET_ROOT, "%d"))

SOURCES.each do |s|
  dest = File.join(TARGET_ROOT, s)
  file dest => s do
    cp_r(s, dest)
  end
  
  task :install => [dest]
  CLOBBER.include(dest)
end

