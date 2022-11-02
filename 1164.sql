with 
    product_change_price_after as (
        select
            product_id,
            10 as price
        from Products
        group by product_id
        having(min(change_date) > "20190816")
    ),
    
    id_last_date_before as (
        select 
            product_id,
            max(change_date) as last_date
        from 
            Products
        where change_date <= "20190816"
        group by product_id
    ),
    
    prodcut_change_price_before as (
        select distinct
            p.product_id,
            new_price as price
        from
            Products p
            inner join id_last_date_before d 
                on (p.product_id = d.product_id and p.change_date = d.last_date)
    )
    
select
    product_id,
    price
from (
    select * from product_change_price_after
    union
    select * from prodcut_change_price_before
) as result