require 'csv'

module ImportTopicsHelper
 
  def self.define_attributes(row)
    attributes = {}
    attributes["topic_identifier"] = row[0].strip
    attributes["topic_name"] = row[1].strip
    attributes["max_choosers"] = row[2]
    attributes["category"] = row[3].strip
    attributes
  end

  def self.create_new_signup_topic(attributes, session)
    signup_topic = SignupTopic.new(attributes)
    signup_topic.assignment_id = session[:assignment_id]
    signup_topic.save
    #signup_topic
  end
end


