with Atleast2OrdersCustID as (
Select O.ocust, Count(O.ordid) as numOrders
from Orders O
group by O.ocust
having count(O.ordid) >= 2),

subsequentOrders as (
select O.odate, O.ocust, min(O1.odate) as nextorder
from Orders O join Orders O1 on O.ocust = O1.ocust join Atleast2OrdersCustID a2o on a2o.ocust = O.ocust
where O.odate < O1.odate
group by O.ocust, O.odate)

select O.ocust, max(O.odate) - min(O.odate) as maxinterval
from Atleast2OrdersCustID a2o join Orders O on a2o.ocust = O.ocust
group by O.ocust
having (max(O.odate) - min(O.odate) = 0)

UNION


Select sqo.ocust, max(sqo.nextorder - sqo.odate) as maxinterval
from subsequentOrders sqo
group by sqo.ocust

order by ocust ASC;