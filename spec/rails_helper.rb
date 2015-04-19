# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

def get_mock_path_to_page_info_file
  "spec/files/pages_info.yml"  
end

VAlexL::MyBlog::PagesInfo::AboutMe.const_set(:PATH_TO_FILE, get_mock_path_to_page_info_file)
