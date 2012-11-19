
desc "Deletes all chapters and questions"
task :delall => :environment do
    ActiveRecord::Base.connection.execute("DELETE FROM chapters")
    ActiveRecord::Base.connection.execute("DELETE FROM questions")
    
end

desc "Import questions from .aqz file"
task :import => :environment do
    require 'xml'
    require 'zip/zip'
    
    puts "Test!"
    unless ENV.include?("if")
        raise "usage: rake import if=/path/to/inputfile.aqz" 
    end
    filename = ENV['if']
    
    def addChapter(chapter, parent)
        chapId = chapter["id"]
        puts "Creating chapter "+chapId+"..."
        chap = Chapter.new({:dispid => chapId, :parent => parent, :name => chapter["name"]})
        chap.save
        
        chapter.find("chapter").each do |subchapter|
            addChapter(subchapter, chap)
        end
        
        chapter.find("question").each do |question|
            puts "Question: "+question.find_first("textquestion").content
            quest = Question.new({:chapter => chap, :dispid => question["id"],
                :question => question.find_first("textquestion").content})
            i = 0
            question.find('textanswer').each do |answer| i += 1
                case i
                when 1; quest.correctanswer = answer.content
                when 2; quest.wronganswer1 = answer.content
                when 3; quest.wronganswer2 = answer.content
                when 4; quest.wronganswer3 = answer.content
                end
            end
            quest.save
        end
    end
    
    # Lets check
    Zip::ZipFile.open(filename) {
        |zf|
        
        puts " zip file contains: #{zf.entries.join(', ')}"
        xmlcode = zf.find_entry('questions.xml').get_input_stream.read
        
        parser, parser.string = XML::Parser.new, xmlcode
        doc = parser.parse
        
        ActiveRecord::Base.transaction do
            doc.find("//aqdf/chapter").each do |topchapter|
                addChapter topchapter, nil
            end
        end
    }
end
