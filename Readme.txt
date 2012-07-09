Project E209: Refactor signup code

The sign_up_sheet_controller.rb had code for creating signup topics, creating teams and setting deadlines. We decided to re-factor the functions depending on their usability to the correct classes.

1. The sign_up_sheet_controller.rb had unrelated code for managing teams. This code was removed and moved to a helper called manage_teamhelper.rb. The functions that have been moved here are

create_team  : not used anywhere but signup_controller.rb under signup
generate_team_name : not used anywhere but in manage_team_helper.rb under create_team
create_team_users : not used anywhere but signup_controller.rb under signup
has_user : not used anywhere but response_controller.rb under redirect_when_disallowed

2. The sign_up_sheet_controller.rb had unrelated code with reference to managing topic deadlines. It was better to move this into a separate helper. So the following functions were moved to deadline_helper.rb

create_topic_deadline : not used anywhere but sign_up_sheet_controller.rb under add_signup_topics_staggered
set_start_due_date : not used anywhere but sign_up_sheet_controller.rb under save_tpoic_dependencies

3. The sign_up_sheet_controller.rb had code for setting up the signup sheet and also code for choosing the signup topic for the users. We broke this down into two controllers. The controller sign_up_sheet_contoller.rb has code for creating signup topics essentially by the admin. It includes the following functions

add_signup_topics_staggered :  
add_signup_topics
view_publishing_rights
load_add_signup_topics
create
redirect_to_sign_up
delete

The signup_controller.rb has code which is essentially seen by the user.

signup_topics
signup
slotAvailable?
confirmTopic
delete_signup
delete_signup_for_topic

The following functional tests were written for the  SignUp controller :

should_be_able_to_view_signup_topics
should_be_able_to_signup_for_topic     
should_be_able_to_drop_topic

The following functional tests were written for the  SignUpSheet controller:

should_show_add_signup_topics_staggered
should_create_new_topic_for_assignment
should_delete_signup_topic_for_assignment
should_be_able_to_edit_topics

Rountree Edits:
    
Removed view_publishing_rights since duplicate of add_signup_topic.
Renamed add_signup_topic to signup_topic since this is more accurate.
Removed has_user from manage_team_helper.rb since it is already defined (similarly but same function) in team.rb. The difference is one or two arguments, but all information is contained in the first argument, so it was redundant.
Moved create_team_users to team.rb, modified for self instead of team_id since team_id can always be determined after it is created.


Branscomb Edits:

Moved create_topic_deadline into the TopicDeadline model as a class method(factory pattern) 
Renamed create_topic_deadline to new_by_due_date
Moved set_start_due_date back into sign_up_sheet_controller because it's only used in that class and doesn't belong in any model.

