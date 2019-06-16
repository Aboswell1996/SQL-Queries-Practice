with goodReaders as(
select DISTINCT O.ocust, 1 as temp
from Orders O join Details D on (O.ordid = D.ordid) join Products P on (D.pcode = P.pcode)
where (P.ptype = 'BOOK') and (date_part('year', O.odate) = '2016')
order by O.ocust ASC)

select boolReaders.custid
from (
    Select C.custid, COALESCE(GR.temp, 0) as bool
    from Customers C left join goodReaders GR  on (C.custid = GR.ocust)
    ) as boolReaders
where boolReaders.bool = 0;