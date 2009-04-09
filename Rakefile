desc 'Run all specs (default)'
task :default => :spec

desc 'Run all specs'
task :spec do 
  system("spec spec")
end

desc 'Build wsfe.exe'
task :build => :compile do
  system("ruby build/rubyscript2exe.rb ./build/wsfe.rb ./build/wsfe.exe")
end

desc 'Run Tar2RubyScript utility, compiling all source files into one single ruby script'
task :compile do
  system("ruby build/tar2rubyscript.rb ./src/ ./build/wsfe.rb")
end

namespace :zip do
  desc 'Zip wsfe.exe'
  task :exe do
    system("7z u ./build/wsfe.zip ./build/wsfe.exe")
  end

  desc 'Zip wsfe source files'
  task :source do
    system("7z u ./build/wsfe-sources.zip ./src/")
  end

  desc 'Zip wsfe.exe and source files'
  task :all => [:exe, :source]
end

desc 'Upload'
task :upload do
  system("curl ftp://ftp.atlanware.com/ -u wsfe@atlanware.com:wsfeafip -T ./build/wsfe.zip ./build/wsfe-sources.zip")
end
