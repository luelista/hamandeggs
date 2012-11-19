class Fach < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  attr_accessible :fach, :user, :question
  
  def self.delall(user)
    Fach.delete_all(:user_id => user)
  end
  
  def self.getstat(user)
    stat = [0,0,0,0,0,0,0]
    res = connection.execute("SELECT COUNT(question_id) AS count,fach FROM faches WHERE user_id = #{user.id.to_i} GROUP BY fach ORDER BY fach")
    logger.debug res.inspect
    res.each do |row|
      stat[0] += row["count"]
      stat[row["fach"]+1] = row["count"]
    end
    return stat
  end
  
end
