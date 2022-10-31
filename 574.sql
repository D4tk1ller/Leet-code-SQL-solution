select c.name
from (
        select candidateId
        from Vote
        group by candidateId
        order by count(id) desc
        limit 1) as winner
    inner join 
        Candidate c on (winner.candidateId = c.id)