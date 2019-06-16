select cast(sum(D.qty)/cast(count(distinct D.ordid) as numeric(6,2)) as numeric(6,2)) as average, P.ptype
from Details D join Products P on (D.pcode = P.pcode)
group by P.ptype;