desc 'Run all specs (default)'
task :default => :spec

desc 'Run all specs'
task :spec do 
  system("cd #{ File.dirname(__FILE__) } ; spec spec")
end

desc 'Build wsfe.exe'
task :build => :compile do
  system("cd #{ File.join(File.dirname(__FILE__), 'build') } ; ruby rubyscript2exe.rb ./wsfe.rb")
end

desc 'Run Tar2RubyScript utility, compiling all source files into one single ruby script'
task :compile do
  system("cd #{ File.join(File.dirname(__FILE__), 'build') } ; ruby tar2rubyscript.rb ../src/ ./wsfe.rb")
end

namespace :zip do
  desc 'Zip wsfe.exe'
  task :exe do
    system("cd #{ File.join(File.dirname(__FILE__), 'build') } ; 7z u wsfe.zip wsfe.exe")
  end

  desc 'Zip wsfe source files'
  task :source do
    system("cd #{ File.join(File.dirname(__FILE__), 'build') } ; 7z u wsfe-sources.zip ../src/")
  end

  desc 'Zip wsfe.exe and source files'
  task :all => [:exe, :source]
end

desc 'Upload'
task :upload do
  system("cd #{ File.join(File.dirname(__FILE__), 'build') } ; curl ftp://ftp.atlanware.com/ -u wsfe@atlanware.com:wsfeafip -T wsfe.zip wsfe-sources.zip")
end
