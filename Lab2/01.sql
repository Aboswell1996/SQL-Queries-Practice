select C.country, Count(O.ocust)
from Customers C LEFT JOIN Orders O on (C.custid = O.ocust)
where (date_part('year', O.odate) = '2016') or (O.odate is NULL)
group by C.country;