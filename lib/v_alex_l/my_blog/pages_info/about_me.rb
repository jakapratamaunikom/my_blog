class VAlexL::MyBlog::PagesInfo::AboutMe
  PATH_TO_FILE = "pages_info.yml"

  attr_reader :page, :lang
  def initialize(lang)
    @lang   = lang
    @values = YAML::load_file VAlexL::MyBlog::PagesInfo::AboutMe::PATH_TO_FILE
    @page   = VAlexL::MyBlog::PagesInfo::Page.new @values[:about_me][lang]
  end

  def save
    @values[:about_me][lang] = page.get_data    
    File.open(VAlexL::MyBlog::PagesInfo::AboutMe::PATH_TO_FILE, 'w') {|f| f.write @values.to_yaml }
  end
end
