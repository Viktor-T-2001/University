use WorldEvents;

with ThisAndThat as (
select EventId,
	   case when lower(EventDetails) like '%this%' then 1 else 0 end as IfThis,
	   case when lower(EventDetails) like '%that%' then 1 else 0 end as IfThat
from tblEvent
)
select IfThis, IfThat,
	   count(*) as NumberOfEvents
from ThisAndThat
group by IfThis, IfThat;

with ThisAndThat as (
select EventId,
	   case when lower(EventDetails) like '%this%' then 1 else 0 end as IfThis,
	   case when lower(EventDetails) like '%that%' then 1 else 0 end as IfThat
from tblEvent
)
select e.EventName, e.EventDetails
from ThisAndThat tt
join tblEvent e
	on e.EventId = tt.EventId
where tt.IfThis = 1 and tt.IfThat = 1;