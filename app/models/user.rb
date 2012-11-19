class User < ActiveRecord::Base
  attr_accessible :email, :fullname, :password, :password_confirmation, :username, :exam_type
  
  validates_length_of :username, :within => 2..40
  #validates_length_of :password, :within => 5..40
  validates_presence_of :username, :salt, :exam_type#, :password, :password_confirmation
  validates_uniqueness_of :username #, :email
  #validates_confirmation_of :password
  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"  
  validates :password, :presence     => true,
                     :confirmation => true,
                     :length       => { :minimum => 5 },
                     :if           => :password # only validate if password changed!
                     
  attr_accessor :password, :password_confirmation
  
  def self.authenticate(login, pass)
    u=find(:first, :conditions=>["username = ?", login])
    return nil if u.nil?
    return u if User.encrypt(pass, u.salt)==u.hashed_password
    nil
  end  

  def password=(pass)
    @password=pass
    self.salt = User.random_string(10) if !self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
  end

  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.username, new_pass)
  end

  def reset
    Fach.delall(self)
    logger.info "RESET FOR " + self.exam_type
    
    case self.exam_type
    when 'afu_e'
      chapters = [Chapter.find_by_dispid('B'), Chapter.find_by_dispid('V'), Chapter.find_by_dispid('T')]
    else
      chapters = []
    end
    chapters.each do |chapter|
      chapter.putAllInFach(0, self)
    end
  end
  
  protected
    
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(len)
    #generat a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

end
