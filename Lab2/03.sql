with TaxedAmounts as (
select D.ordid, cast(sum(D.qty * P.price*1.2) as numeric(6,2)) as tempamount
from Details D join Products P on (D.pcode = P.pcode)
group by D.ordid
)

Select I.invid
from Invoices I join TaxedAmounts T on (I.ordid = T.ordid) and (I.amount = T.tempamount)
Order by I.invid ASC;