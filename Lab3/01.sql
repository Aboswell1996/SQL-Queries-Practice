select T3.min1 as ptype, count(T3.min1)
from (
    select T2.ordid, sum(P.price) as price1, min(P.ptype) as min1
    from(
        select T1.ordid
        from (
            select O.ordid, count(distinct P.ptype) as numPtypes
            from Orders O join Details D on (O.ordid = D.ordid) join Products P on (D.pcode = P.pcode)
            group by O.ordid
            order by O.ordid ASC
            ) as T1
        where (T1.numPtypes = 1)
        order by T1.ordid ASC
        ) as T2

    join Details D on (T2.ordid = D.ordid) join Products P on (D.pcode = P.pcode)
    group by T2.ordid, P.ptype
    order by T2.ordid
    ) as T3
group by T3.min1;