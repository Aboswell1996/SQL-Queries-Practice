with temp2 as (
            select sum(sO.sum1) as sum2, sO.ocust as test1, count(sO.ordid), 1 as temp
            from (
            select sum(D.qty* P.price) as sum1,O.ocust, O.ordid
            from Customers C left join Orders O on (C.custid = O.ocust) join Details D on (O.ordid = D.ordid) join Products P on (P.pcode = D.pcode)
            where  (O.odate >= '2016-01-01') and (O.odate <= '2016-06-30') and (P.ptype = 'MUSIC')
            group by O.ordid
            ) as sO
        group by sO.ocust
)

select sC.ocust as custid, sC.sum2
from
    (
    select sum(sO.sum1) as sum2, sO.ocust, count(sO.ordid)
    from (
        select sum(D.qty* P.price) as sum1,O.ocust, O.ordid
        from Customers C left join Orders O on (C.custid = O.ocust) join Details D on (O.ordid = D.ordid) join Products P on (P.pcode = D.pcode)
        where  (O.odate >= '2016-01-01') and (O.odate <= '2016-06-30') and (P.ptype = 'MUSIC')
        group by O.ordid
        ) as sO
    group by sO.ocust
    ) as sC
where (sC.sum2 <50)

union

select zs.custid, zs.sum2
from (
    select C.custid, COALESCE(t2.temp, 0) as sum2
    from Customers C left join temp2 t2 on C.custid = t2.test1
    ) as zs
where zs.sum2 = 0
order by custid ASC;