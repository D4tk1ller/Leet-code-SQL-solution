with
    distinct_id_loginDate as (
        select distinct id, login_date
        from Logins
    ),

    count_consecutive_days_after as (
        select distinct 
            t1.id
        from 
            distinct_id_loginDate t1
            inner join distinct_id_loginDate t2
                on (
                    t1.id = t2.id 
                    and datediff(t2.login_date, t1.login_date) < 5 
                    and datediff(t2.login_date, t1.login_date) >= 0
                )
        
        group by t1.id, t1.login_date
        having count(*) >= 5
    )
    
select
    a.id,
    a.name
from 
    Accounts a
    inner join count_consecutive_days_after l 
        using(id)
order by a.id


