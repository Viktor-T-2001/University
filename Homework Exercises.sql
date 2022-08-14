use HomeworkDB;
go

-- 1. Retrieve a list of all roles in the company, which should include the number of employees for each of role assigned
select re.Name as RoleName,
	   count(distinct r.EmployeeId) as NumOfEmpl
from tb_Role re
left join tb_RoleEmpl r
	on r.RoleId = re.RoleId
group by re.Name
order by NumOfEmpl desc; 

-- 2. Get roles which has no employees assigned
select distinct re.Name
from tb_Role re
left join tb_RoleEmpl r
	on r.RoleId = re.RoleId
where r.RoleId is null;

-- 3. Get projects list where every project has list of roles supplied with number of employees
select p.Name as ProjectName,
	   r.Name as RoleName,
	   count(distinct re.EmployeeId) as NumOfEmpl
from tb_Project p
join tb_RoleEmpl re
	on re.ProjectId = p.ProjectId
left join tb_Role r
	on r.RoleId = re.RoleId
group by p.Name, r.Name
order by p.Name, r.Name;

-- 4. For every project count how many tasks there are assigned for every employee in average
with cte as (
select p.Name as ProjectName,
	   t.EmployeeId,
	   count(t.TaskId) as TasksAssigned
from tb_Project p
left join tb_Task t
	on t.ProjectId = p.ProjectId
group by p.Name,
	     t.EmployeeId
)
select ProjectName,
	   cast(1.00*sum(TasksAssigned)/count(*) as numeric(4,2)) as AvgTasksAssigned
from cte
group by ProjectName
order by ProjectName;

-- 5. Determine duration for each project
select
	"Name" as ProjectName,
	case when DateClosed is null
		 then datediff(month, DateCreated, cast(getdate() as date))
		 else datediff(month, DateCreated, DateClosed)
	end as ProjectDurationMonths
from tb_Project;

-- 6. Identify which employees has the lowest number tasks with non-closed statuses.
with cte as (
select t.EmployeeId,
	   count(t.TaskId) as NumOfTasks
from tb_Task t
where t.TaskStatusId in (select TaskStatusId 
						 from tb_Task_Status
						 where StatusName <> 'Accepted (closed)')
group by t.EmployeeId
)
select  e.FirstName + ' ' + e.MiddleName + ' ' + e.LastName as EmployeeName,
		c.NumOfTasks
from cte c
join tb_Employee e
	on c.EmployeeId = e.EmployeeId
where c.NumOfTasks = (select min(NumOfTasks) from cte);

-- 7. Identify which employees has the most tasks with non-closed statuses with failed deadlines.
with cte as (
select t.EmployeeId,
	   count(t.TaskId) as NumOfTasks
from tb_Task t
where t.TaskStatusId in (select TaskStatusId 
						 from tb_Task_Status
						 where StatusName <> 'Accepted (closed)')
	  and isnull(t.DateClosed, cast(getdate() as date)) > t.DateExpected
group by t.EmployeeId
)
select  e.FirstName + ' ' + e.MiddleName + ' ' + e.LastName as EmployeeName,
		c.NumOfTasks
from cte c
join tb_Employee e
	on c.EmployeeId = e.EmployeeId
where c.NumOfTasks = (select max(NumOfTasks) from cte);

-- 8. Move forward deadline for non-closed tasks in 5 days.
select * from tb_Task;

update tb_Task
set DateExpected = dateadd(day, 5, DateExpected) 
from tb_Task 
where TaskStatusId in (select TaskStatusId 
						 from tb_Task_Status
						 where StatusName <> 'Accepted (closed)');

select * from tb_Task;

-- 9. For each project count how many there are tasks which were not started yet.
select p.Name as ProjectName,
	   count(t.TaskId) as NumOfTasks
from tb_Project p
left join tb_Task t
	on t.ProjectId = p.ProjectId
where t.TaskStatusId in (select TaskStatusId 
						 from tb_Task_Status
						 where StatusName = 'Open')
group by p.Name
order by NumOfTasks desc;

-- 10. For each project which has all tasks marked as closed move status to closed. Close date for such project should match close date for the last accepted task.
select * from tb_Project;

with ProjectsStats as (
select p.ProjectId,
	   count(t.TaskId) as NumOfTasks,
	   sum(case when t.TaskStatusId = 4 then 1 else 0 end) as ClosedTasks,
	   max(case when t.TaskStatusId = 4 then t.DateClosed else null end) as TaskClosedDate
from tb_Project p
left join tb_Task t
	on t.ProjectId = p.ProjectId
where p.ProjectStatusId <> (select ProjectStatusId 
						    from tb_Project_Status
							where StatusName = 'Closed')
group by p.ProjectId
),
ProjectsWithAllTasksClosed as (
select *
from ProjectsStats
where NumOfTasks = ClosedTasks
)
update tb_Project
set ProjectStatusId = 2,
	DateClosed = pc.TaskClosedDate
from tb_Project p
join ProjectsWithAllTasksClosed pc
	on pc.ProjectId = p.ProjectId;

select * from tb_Project;

-- 11. Determine employees across all projects which has not non-closed tasks assigned.
select e.FirstName + ' ' + e.MiddleName + ' ' + e.LastName as EmployeeName,
	   sum(case when t.TaskStatusId = 4 then 0 else 1 end) as NumOfNonClosedTasks
from tb_Task t
join tb_Employee e
	on e.EmployeeId = t.EmployeeId
group by t.EmployeeId,
		 e.FirstName,
		 e.MiddleName,
		 e.LastName
having sum(case when t.TaskStatusId = 4 then 0 else 1 end) = 0;

-- 12. Assign given project task (using task name as identifier) to an employee which has minimum tasks with open status.
select * from tb_Task;

with OpenTasksCount as (
select t.EmployeeId,
	   sum(case when t.TaskStatusId = 1 then 0 else 1 end) as NumOfNonClosedTasks
from tb_Task t
join tb_Employee e
	on e.EmployeeId = t.EmployeeId
group by t.EmployeeId
),
EmplToUpd as (
select top 1 EmployeeId
from OpenTasksCount
where NumOfNonClosedTasks = (select min(NumOfNonClosedTasks) from  OpenTasksCount)
order by EmployeeId asc
)
update tb_Task
set EmployeeId = u.EmployeeId
from EmplToUpd u
where "Name" = 'TaskQ';

select * from tb_Task;