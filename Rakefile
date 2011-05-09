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

namespace :build do
  desc "Build all exes"
  task :all => [:wsfe, :wsfew, :wsfex, :wsfexw]

  desc "Build wsfe.exe"
  task :wsfe do
    system("ocra bin\wsfe.rb lib\wsferb\wsaa\wsaa.wsdl lib\wsferb\wsfe\wsfev1.wsdl lib\wsferb\wsfex\wsfex.wsdl --console")
  end

  desc "Build wsfew.exe"
  task :wsfew do
    system("ocra bin\wsfe.rb lib\wsferb\wsaa\wsaa.wsdl lib\wsferb\wsfe\wsfev1.wsdl lib\wsferb\wsfex\wsfex.wsdl --windows")
  end

  desc "Build wsfex.exe"
  task :wsfex do
    system("ocra bin\wsfex.rb lib\wsferb\wsaa\wsaa.wsdl lib\wsferb\wsfe\wsfev1.wsdl lib\wsferb\wsfex\wsfex.wsdl --console")
  end

  desc "Build wsfexw.exe"
  task :wsfexw do
    system("ocra bin\wsfex.rb lib\wsferb\wsaa\wsaa.wsdl lib\wsferb\wsfe\wsfev1.wsdl lib\wsferb\wsfex\wsfex.wsdl --windows")
  end
end

desc "Build docs"
task :docs do
  format = ENV["format"] || "html"
  system "cd docs && make #{format}"
end

namespace :zip do
  desc "Zip exes"
  task :exe do
    system("cd build && 7z u wsfe-bin.zip wsfe.exe wsfew.exe wsfex.exe wsfexw.exe")
  end

  desc "Zip wsfe source files"
  task :source do
    system("cd build && 7z u wsfe-sources.zip ../src/")
  end

  desc "Zip wsfe.exe and source files"
  task :all => [:exe, :source]
end

desc "Upload"
task :upload do
  system("cd build && curl ftp://ftp.atlanware.com/ -u wsfe@atlanware.com:savon20 -T ./wsfe-bin.zip ./wsfe-sources.zip")
end
