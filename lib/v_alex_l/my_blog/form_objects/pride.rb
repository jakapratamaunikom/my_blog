class VAlexL::MyBlog::FormObjects::Pride
  def initialize
  end
  
  def apply!(arguments)
    ::Pride.destroy_all
    arguments.keys.each do |lang|
      create_prides_for_lang!(lang, arguments[lang])
    end
    true
  end

  def is_article_select?(article)
    ::Pride.where(objective_type: 'Article', objective_id: article.id).count > 0
  end

  def is_work_select?(work)
    ::Pride.where(objective_type: 'Work', objective_id: work.id).count > 0
  end

  private 
    def create_prides_for_lang!(lang, prides_arguments)
      prides_arguments.inject([]) do |prides, arguments|
        objective_type, objective_id = arguments.split
        prides.push ::Pride.create(lang: lang, objective_id: objective_id, objective_type: objective_type)
      end
    end
end
