-- # 1
select cs.Name as ClientStatus, 
	   count(*) as NumOfClients
from dbo.tb_clients c
join dbo.tb_Client_Status cs
	on cs.id = c."Status"
group by cs.Name
order by NumOfClients desc;

-- # 2
with cte as (
select id as ClientId,
	   case when RiskLevel <= 40 then 'Низький рівень ризику'
			when RiskLevel <= 60 then 'Середній рівень ризику'
			when RiskLevel <= 95 then 'Високий рівень ризику'
			when RiskLevel > 95 then 'Захмарний рівень ризику'
	   end as RiskLevelDescr	
from dbo.tb_Clients
where "Status" = 0 or "Status" = 2
)
select RiskLevelDescr,
	   count(*) as NumOfClients
from cte
group by RiskLevelDescr
order by NumOfClients;

-- # 3
select top 100
	   c.id as CLientId,
	   c.lname,
	   c.fname,
	   c.mname,
	   c.RiskLevel,
	   c.Date_from,
	   c.Date_birth,
	   case	when tr.CCY is null 
			then 'UAH' else tr.CCY
		end as Curr,
		case when ts.Id in (1001, 1002) 
			then 'Кредит' else 'Депозит'
		end as TreatyType,
		count(*) as NumOfAgr
from dbo.tb_Clients c
join tb_Treaty tr
	on tr.ClientId = c.id
join dbo.tb_Treaty_Systems ts
	on ts.id = tr.SystemId
where c."Status" in (0, 2)
group by c.id, 
	   c.lname,
	   c.fname,
	   c.mname,
	   c.RiskLevel,
	   c.Date_from,
	   c.Date_birth,
	   tr.CCY, 
	   ts.Id
having count(*) > 1
order by NumOfAgr desc;

-- # 4
with cte as (
select ts.Name as TreatyType,
		case when tr.CCY is not null
			then tr.Amount * tr.ExRate
			else tr.Amount
		end as TreatyAmount
from dbo.tb_Treaty tr
join dbo.tb_Treaty_Systems ts
	on ts.id = tr.SystemId
join dbo.tb_Clients c
	on c.id = tr.CLientId
	and c.Status in (2, 0)
)
select  TreatyType, 
		count(*) as NumOfAgr,
		avg(TreatyAmount) as AvgAmount
from cte
group by TreatyType
order by AvgAmount desc;

-- # 5
select  count(distinct clientid) as CountClientsWithTreaties,
		max(Amount) as MaxTreatyAmount,
		min(Amount) as MinTreatyAmount,
		avg(Amount) as AvgTreatyAmount,
		sum(Amount) as TotalTreatyAmount
from (select id, 
			 clientid, 
			 Amount 
	  from dbo.tb_Treaty
	  where CCY is not null and Closed = 1) as t;

-- # 6
select dense_rank() over(partition by d.CLientId order by d.TreatyAmount desc) as rn,
	   d.ClientId,
	   d.ClientName,
	   d.TreatyAmount
from (
select c.id as clientid,
	   trim(c.fname) + ' ' + trim(c.mname) + ' ' + trim(c.lname) as ClientName,
	   t.Amount as TreatyAmount
from dbo.tb_Clients c
left join dbo.tb_Treaty t
	on t.ClientId = c.Id
where c.Date_from between '1950-01-01' and '2001-12-31'
	  and c."Status" in (0, 1, 2)

union

select c.id as clientid,
	   trim(c.fname) + ' ' + trim(c.mname) + ' ' + trim(c.lname) as ClientName,
	   t.Amount as TreatyAmount
from dbo.tb_Clients c
left join dbo.tb_Treaty t
	on t.ClientId = c.Id
where t.CCY is not null and t.Rate is not null
	  and c."Status" = 3
) as d
where d.TreatyAmount > (select min(Amount)*2 
					    from dbo.tb_Treaty) ;
