select round (
                ifnull(count(distinct a2.player_id), 0) 
                    / count(distinct a1.player_id), 2
            ) as fraction
from (  
        select player_id, min(event_date) as firstDate
        from Activity
        group by player_id
     ) as a1
        
    left join 
        Activity a2
        on (a1.player_id = a2.player_id and a1.firstDate + 1 = a2.event_date)