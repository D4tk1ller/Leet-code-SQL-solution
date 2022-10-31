select e.name
from (
        select managerId
        from Employee 
        where managerId is not null
        group by managerId
        having count(id) >= 5
    ) as m
    inner join 
        Employee e on (m.managerId = e.id)