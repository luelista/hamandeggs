class Chapter < ActiveRecord::Base
  belongs_to :parent, :class_name => "Chapter"
  has_many :children, :class_name => "Chapter", :foreign_key => "parent_id"
  has_many :questions  #, :class_name => "Question", :foreign_key => "chapter_id"
  attr_accessible :dispid, :name, :parent
  
  def putAllInFach(fachnr, user)
    self.children.each { |chch|
      chch.putAllInFach(fachnr, user)
    }
    
    transaction do
      self.questions.each { |qu|
        fach = Fach.new({:user => user, :question => qu, :fach => fachnr})
        fach.save
      }
    end
  end
end
