#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
$: << File.expand_path(File.dirname(__FILE__) + "/lib")

require 'lib/wsfe'
require 'lib/wsfex'
require 'silence'
require 'rubyscript2exe'

if RUBYSCRIPT2EXE.is_compiled?
  ee_base_folder = File.expand_path(RUBYSCRIPT2EXE.appdir + "/../..")
  ee_folder = File.expand_path(RUBYSCRIPT2EXE.appdir + "/..")
  name_parts =  ee_folder.split(".")
  curr_ee_folder_number = name_parts[3].to_i
  last_ee_folder_number = curr_ee_folder_number - 1
  Dir.entries(ee_base_folder).each do |folder|
    if (folder != ".") and (folder != "..") and (folder.split(".")[3].to_i != curr_ee_folder_number)
      folder_to_del = ee_base_folder + "/" + folder
      FileUtils.remove_dir(folder_to_del, true) 
    end
  end
  $stderr.reopen(RUBYSCRIPT2EXE.userdir + "/wsfe.log","w")
  $stderr.sync = true
end

silence_warnings do
  if WSFEX::SERVICES.include?(ARGV[0])
    WSFEX::Runner::Wsfex.run(ARGV)
  else
    WSFE::Runner::Wsfe.run(ARGV)
  end
end

exit 0
