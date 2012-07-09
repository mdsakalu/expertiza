class TopicDeadline < ActiveRecord::Base
  belongs_to :topic, :class_name => 'SignUpTopic'

  validate :due_at_is_valid_datetime

  def due_at_is_valid_datetime
    errors.add(:due_at, 'must be a valid datetime') if ((DateTime.strptime(due_at.to_s, '%Y-%m-%d %H:%M:%S') rescue ArgumentError) == ArgumentError)
  end

  #Creates a new topic deadline for topic specified by topic_id.
  # The deadline itself is specified by due_date object which contains several values which specify
  # type { submission deadline, resubmission deadline, metareview deadline etc} a ste of other parameters that
  #specify if submission, resubmission review, re review etc are allowed for the particular deadline
  def self.new_by_due_date(due_date, offset, topic_id)
    topic_deadline = self.new
    topic_deadline.topic_id = topic_id
    topic_deadline.due_at = DateTime.parse(due_date.due_at.to_s) + offset.to_i
    topic_deadline.deadline_type_id = due_date.deadline_type_id
    topic_deadline.late_policy_id = due_date.late_policy_id
    topic_deadline.submission_allowed_id = due_date.submission_allowed_id
    topic_deadline.review_allowed_id = due_date.review_allowed_id
    topic_deadline.resubmission_allowed_id = due_date.resubmission_allowed_id
    topic_deadline.rereview_allowed_id = due_date.rereview_allowed_id
    topic_deadline.review_of_review_allowed_id = due_date.review_of_review_allowed_id
    topic_deadline.round = due_date.round
    topic_deadline.save
  end
end
