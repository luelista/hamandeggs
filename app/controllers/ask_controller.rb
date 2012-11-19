class AskController < ApplicationController
  def chapters
    @chapters = Chapter.where(:parent_id => nil)
    
  end

  def chapter
    @chapter = Chapter.find_by_dispid_and_parent_id!(params[:dispid], nil)
    @subchapters = @chapter.children
    
    @curid = params[:subid].to_i
    if @curid > 0 then
      @cur_chapter = Chapter.find(@curid)
      if @cur_chapter then
        @questions = Question.find_all_by_chapter_id(@cur_chapter.id)
      end
    end
  end
  
  def answer
    question = Question.find_by_dispid(params[:question])
    fach = Fach.find_by_user_id_and_question_id(current_user.id, question.id)
    if params[:answer] == "correct" then
      fach.fach += 1
    else
      fach.fach = 1
    end
    fach.save
    render :json => "success"
  end
  
  def statistics
    @stats = Fach.getstat(current_user)
    respond_to do |format|
      format.html
      format.js { render :text => render_to_string(:partial => "ask/ministats.html") }
    end
  end
  
  def nextquestion
    offset = rand(Question.count)
    @question = Question.first(:offset => offset)
    render :json => @question
  end
  
  def learn
    @stats = Fach.getstat(current_user)
  end

  def test
  end
end
