with Atleast5OrdersCustID as (
 Select O.ocust
        from Orders O
        group by O.ocust
        having count(DISTINCT O.odate) >= 5),
intervals as (             
select O.odate, O.ocust, min(O1.odate) as nextorder
from Orders O join Orders O1 on O.ocust = O1.ocust join Atleast5OrdersCustID a5o on a5o.ocust = O.ocust
where O.odate < O1.odate
group by O.ocust, O.odate
order by O.ocust ASC)

select I.ocust
from intervals I
group by I.ocust
having avg(I.nextorder - I.odate) < 30
Order by I.ocust ASC;