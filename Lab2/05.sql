select T.custid, count(DISTINCT T.ordid), cast(sum(T.price*T.qty)/count(DISTINCT T.ordid) as numeric(6,2)) as average
from 
    (Select C.custid, C.cname, COALESCE(O.ordid,0) as ordid, COALESCE(D.qty, 0) as qty, D.pcode, P.ptype, COALESCE(P.price, 0) as price
    from Customers C left join Orders O on (C.custid = O.ocust) left join Details D on (D.ordid = O.ordid) left join Products P on (P.pcode = D.pcode)
    where O.ordid is not NULL
    order by C.custid DESC
    ) as T
group by T.custid

UNION

select T2.custid, count(DISTINCT T2.ordid), cast(COALESCE(NULL, NULL) as int) as average
from (
    Select C.custid, C.cname, O.ordid, COALESCE(D.qty, 0) as qty, D.pcode, P.ptype, COALESCE(P.price, 0) as price
    from Customers C left join Orders O on (C.custid = O.ocust) left join Details D on (D.ordid = O.ordid) left join Products P on (P.pcode = D.pcode)
    where O.ordid is NULL
    order by C.custid DESC
    ) as T2
group by t2.custid

order by custid DESC;