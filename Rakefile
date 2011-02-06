require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
end

task :default => :test

namespace :test do
  Rake::TestTask.new do |t|
    t.name = :unit
    t.libs << "test"
    t.pattern = "test/unit/*_test.rb"
  end
  Rake::TestTask.new do |t|
    t.name = :integration
    t.libs << "test"
    t.pattern = "test/integration/*_test.rb"
  end
end

desc 'Build wsfe.exe'
task :build => :compile do
  system("cd build && ruby rubyscript2exe.rb wsfe.rb")
end

desc 'Run Tar2RubyScript utility, compiling all source files into one single ruby script'
task :compile do
  system("cd build && ruby tar2rubyscript.rb ../src/ wsfe.rb")
end

namespace :zip do
  desc 'Zip wsfe.exe'
  task :exe do
    system("cd build && 7z u wsfe.zip wsfe.exe")
  end

  desc 'Zip wsfe source files'
  task :source do
    system("cd build && 7z u wsfe-sources.zip ../src/")
  end

  desc 'Zip wsfe.exe and source files'
  task :all => [:exe, :source]
end

desc 'Upload'
task :upload do
  system("cd build && curl ftp://ftp.atlanware.com/ -u wsfe@atlanware.com:wsfeafip -T ./wsfe.zip ./wsfe-sources.zip")
end
