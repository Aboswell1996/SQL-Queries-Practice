select t3.ptype, t3.ocust
from (
    select max(t1.sum1) as max1,t1.ptype
    from (
        select P.ptype, sum(D.qty) as sum1, O.ocust
        from Details D join Orders O on (D.ordid = O.ordid) join Products P on (D.pcode = P.pcode)
        group by P.ptype, O.ocust
        order by sum(D.qty) DESC
        ) as t1
    group by t1.ptype
    ) as t2,
    (
    select P.ptype, sum(D.qty) as sum1, O.ocust
    from Details D join Orders O on (D.ordid = O.ordid) join Products P on (D.pcode = P.pcode)
    group by P.ptype, O.ocust
    order by sum(D.qty) DESC
    ) as t3
    where (t3.ptype = t2.ptype) and (t3.sum1 = t2.max1);