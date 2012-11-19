class Question < ActiveRecord::Base
  belongs_to :chapter
  attr_accessible :chapter, :correctanswer, :dispid, :question, :wronganswer1, :wronganswer2, :wronganswer3
end
