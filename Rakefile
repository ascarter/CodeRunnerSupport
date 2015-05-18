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

OBJECTS.zip(SOURCES).each do |target, source|
  target_dir = target.pathmap("%d")
  directory target_dir
  file target => [target_dir, source] do
    cp_r(source, target)
  end
  CLOBBER.include(target)
end
