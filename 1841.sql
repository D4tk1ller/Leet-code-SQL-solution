# Write your MySQL query statement below
with 
    goals_home_team as (
        select  
            home_team_id as team_id,
            home_team_goals as goal_for,
            away_team_goals as goal_against
        from 
            Matches
    ),

    goals_away_team as (
        select  
            away_team_id as team_id,
            away_team_goals as goal_for,
            home_team_goals as goal_against
        from 
            Matches
    ),

    goals_team as (
        select * from goals_home_team
        union all
        select * from goals_away_team
    )

select          
    team_name,
    count(t.team_id) as matches_played,
    sum(
        case
            when (goals_team.goal_for > goals_team.goal_against) then 3
            when (goals_team.goal_for = goals_team.goal_against) then 1
            else 0
        end
    ) as points,
    sum(goals_team.goal_for) as goal_for,
    sum(goals_team.goal_against) as goal_against,
    sum(goal_for - goal_against) as goal_diff
from 
    Teams t
    inner join goals_team 
        using(team_id)
group by t.team_id
order by points desc, goal_diff desc, team_name asc
