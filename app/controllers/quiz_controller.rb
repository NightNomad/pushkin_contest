class QuizController < ApplicationController

TOKEN = '73e6aaa1f1c2eab3dfa80e414ae51038'

  def quiz
    render nothing: true
    poems = Poem.all 

      if params[:level] == 1
        substring = params[:question]

        answer = search_title(substring, poems)

        uri = URI("http://pushkin.rubyroid.by/quiz")
        parameters = {
          answer: answer,
          token: TOKEN,
          task_id: params[:id]
        }
        Net::HTTP.post_form(uri, parameters)

      else params[:level] == 2
        question = params[:question]
        n = question.scan(/[[:word:]]+/).index("WORD")
        question = question.delete('%WORD%').split(" ").to_s
        answer = search_word(question, poems)

        uri = URI("http://pushkin.rubyroid.by/quiz")
        parameters = {
          answer: answer,
          token: TOKEN,
          task_id: params[:id]
        }
        Net::HTTP.post_form(uri, parameters)  
      end  
  end

  private
  def search_title(search_string, poems)
    poems.each do |single_poem| 
      return single_poem.title if single_poem.poem.include?(search_string)
    end
  end

  def search_word(search_string, poems)
    poems.each do |single_poem| 
      return single_poem.poem.string[n] if single_poem.poem.include?(search_string)
    end
  end


  def poem_params
    params.require(:poem).permit(:id, :created_at, :updated_at, :title, :poem)
  end
end
