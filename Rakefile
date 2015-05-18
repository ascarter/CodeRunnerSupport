require 'rake'
require 'rake/clean'

TARGET_ROOT = File.expand_path("~/Library/Application Support/CodeRunner")
SOURCES = Rake::FileList["Grammars/*.plist", "Languages/*.crLanguage"]
OBJECTS = SOURCES.pathmap(File.join(TARGET_ROOT, "%p"))

desc "Uninstall"
task :uninstall => :clobber

desc "Install"
task :install => OBJECTS

task :default => :install

# Destination directories
directory File.join(TARGET_ROOT, 'Grammars')
directory File.join(TARGET_ROOT, 'Languages')

OBJECTS.zip(SOURCES).each do |target, source|
  file target => [target.pathmap("%d"), source] do
    cp_r(source, target)
  end
  CLOBBER.include(target)
end
