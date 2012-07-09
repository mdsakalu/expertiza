# This helper contains all functions associated with team management. 
# These include creating a new team, adding a new member to a team etc
# This helper is used by both sign_up_sheet controller and signup controller
module ManageTeamHelper

#Creates a new team. When a user signs up for a topic he/she is in his/her own team
#when other people join the user's team the database tables are updated to reflect these changes

  def create_team(assignment_id)
    assignment = Assignment.find(assignment_id)   
    teamname = generate_team_name(assignment.name)
    team = AssignmentTeam.create(:name => teamname, :parent_id => assignment.id)
    TeamNode.create(:parent_id => assignment.id, :node_object_id => team.id)
    team
  end
# team names are created as assignment_name_Team<team_number>
  def generate_team_name(teamnameprefix)
    counter = 1
    while (true)
      teamname = teamnameprefix + "_Team#{counter}"
      if (!Team.find_by_name(teamname))
        return teamname
      end
      counter=counter+1
    end
  end

end
