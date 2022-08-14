use [master]
go

drop database if exists HomeworkDB;
create database HomeworkDB;
go 

use HomeworkDB;
go 

create table tb_Project_Status(
	ProjectStatusId		integer		not null,
	StatusName			varchar(6)	not null,
	primary key (ProjectStatusId)
);

create table tb_Task_Status(
	TaskStatusId		integer		not null,
	StatusName			varchar(25)	not null,
	primary key (TaskStatusId)
);

create table tb_Project(				
	ProjectId			integer		not null,
	"Name"				varchar(40)	not null,
	DateCreated			date		not null,
	DateClosed			date		null,
	ProjectStatusId		integer		not null,
	primary key	(ProjectId),
	constraint FK_tb_Project_Status_tb_Project foreign key (ProjectStatusId)
	references tb_Project_Status(ProjectStatusId)
);

create table tb_Employee(					
	EmployeeId			integer		not null,
	FirstName			varchar(30)	not null,
	MiddleName			varchar(30)	not null,
	LastName			varchar(30)	not null,
	StartDate			date		not null,
	EndDate				date		null,
	primary key (EmployeeId)
);

create table tb_Role(	
	RoleId				integer		not null,
	"Name"				varchar(30)	not null,
	primary key (RoleId)
);

create table tb_RoleEmpl(		
	RoleId				integer		not null,
	ProjectId			integer		not null,
	EmployeeId			integer		not null,
	constraint FK_tb_Employee_tb_RoleEmpl foreign key (EmployeeId)
	references tb_Employee(EmployeeId),
	constraint FK_tb_Project_tb_RoleEmpl foreign key (ProjectId)
	references tb_Project(ProjectId),
	constraint FK_tb_Role_tb_RoleEmp foreign key (RoleId)
	references tb_Role(RoleId)
);

create table tb_Task(				
	TaskId				integer		not null,
	ProjectId			integer		not null,
	EmployeeId			integer		not null,
	TaskStatusId		integer		not null,
	"Name"				varchar(20)	not null,
	DateCreated			date		not null,
	DateExpected		date		not null,
	DateClosed			date		null,
	primary key (TaskId),
	constraint FK_tb_Project_tb_Task foreign key (ProjectId)
	references tb_Project(ProjectId),
	constraint FK_tb_Task_Status_tb_Task foreign key (TaskStatusId)
	references tb_Task_Status(TaskStatusId),
	constraint FK_tb_Employee_tb_Task foreign key (EmployeeId)
	references tb_Employee(EmployeeId)
);

create table tb_Task_History(				
	TaskId				integer		not null,
	ProjectId			integer		not null,
	EmployeeId			integer		not null,
	TaskStatusId		integer		not null,
	"Name"				varchar(20)	not null,
	DateCreated			date		not null,
	DateExpected		date		not null,
	DateClosed			date		null,
	DateChanged			date		null,
	TimeChanged			time		null,
	OperationType		varchar(25)	null,
	ResponsibleChange	varchar(50)	null,
	constraint FK_tb_Project_tb_Task_History foreign key (ProjectId)
	references tb_Project(ProjectId),
	constraint FK_tb_Task_Status_tb_Task_History foreign key (TaskStatusId)
	references tb_Task_Status(TaskStatusId),
	constraint FK_tb_Employee_tb_Task_History foreign key (EmployeeId)
	references tb_Employee(EmployeeId)
);

insert into tb_Employee(EmployeeId, FirstName, MiddleName, LastName, StartDate, EndDate)
values
(1,'Gisela','Kennet','Derby','2011-1-14',null),
(2,'Jesse','David','Kuipers','2011-1-14',null),
(3,'Serena','Othmar','Hammond','2011-1-14',null),
(4,'Griet','William','Easton','2011-1-14',null),
(5,'Ileen','Sherrie','Lamb','2011-1-14',null),
(6,'Branka','Hanna','Hopper','2011-1-14',null),
(7,'Kiefer','Zavia','Sims','2011-1-14',null),
(8,'Carina','Euphemia','Haley','2014-5-4',null),
(9,'Aaren','Kristin','Myers','2014-5-4',null),
(10,'Flint','Giselle','Sams','2014-5-4',null),
(11,'Kaye','Delta','Eustis','2014-5-4',null),
(12,'Eldon','Stacee','Palmer','2014-5-4',null),
(13,'Tamra','Alanna','Carlyle','2014-5-4',null),
(14,'Ciara','Rosabella','Dyer','2014-5-4',null),
(15,'Chelsie','Berniece','Winchester','2014-5-4',null),
(16,'Gracelyn','Kaydence','Emmett','2015-1-14',null),
(17,'Kingston','Diamond','Headley','2015-1-14',null),
(18,'Gale','Asher','Peck','2015-1-14',null),
(19,'Katy','Vale','Thwaite','2015-1-14',null),
(20,'Ivor','Mimi','Ball','2015-1-14',null),
(21,'Hyram','Melesina','Banks','2015-1-14',null),
(22,'Kinsley','Joe','Emerson','2015-1-14',null),
(23,'Camryn','Deloris','Ayers','2015-1-14',null),
(24,'Clarissa','Bertrand','Troy','2015-1-14',null)
;

insert into tb_Project_Status(ProjectStatusId, StatusName)
values
(1,	'Open'),
(2,	'Closed')
;

insert into tb_Task_Status(TaskStatusId, StatusName)
values
(1,	'Open'),
(2,	'Done'),
(3,	'Need work'),
(4,	'Accepted (closed)')
;

insert into tb_Role(RoleId,	"Name")
values
(1,'Database Administrator'),
(2,'Power BI Developer'),
(3,'Junior BI Developer'),
(4,'Middle BI Developer'),
(5,'Senior BI Developer'),
(6,'Data Analyst'),
(7,'Junior Data Engineer'),
(8,'Middle Data Engineer'),
(9,'Senior Data Engineer'),
(10,'Team Lead'),
(11,'QA Engineer'),
(12,'Junior Python Developer'),
(13,'Middle Python Developer'),
(14,'Senior Python Developer'),
(15,'Junior Software Engineer'),
(16,'Middle Software Engineer'),
(17,'Senior Software Engineer'),
(18,'Intern')
;

insert into tb_Project(ProjectId, "Name", DateCreated, DateClosed, ProjectStatusId)
values
(1,	'Banking', '2015-01-14', '2018-04-04', 2),
(2,	'Oil and gasCompany', '2015-01-14', null, 1), 
(3,	'Telecommunications Company',	'2015-01-14', null, 1),
(4,	'Transhipment Company', '2018-05-04', null, 1),
(5,	'Restaurant Network', '2019-07-03', null, 1)
;

insert into tb_RoleEmpl(RoleId,	ProjectId, EmployeeId)
values
(1,1,1),
(5,1,5),
(10,1,10),
(13,1,12),
(5,1,19),
(12,1,24),
(1,2,1),
(4,2,4),
(10,2,10),
(11,2,11),
(4,2,18),
(9,2,23),
(3,3,3),
(1,3,5),
(6,3,5),
(9,3,9),
(10,3,10),
(3,3,17),
(8,3,22),
(9,4,1),
(2,4,2),
(6,4,5),
(8,4,8),
(10,4,10),
(13,4,13),
(2,4,16),
(7,4,21),
(9,5,1),
(6,5,6),
(7,5,7),
(10,5,10),
(13,5,14),
(1,5,15),
(6,5,20)
;
go

create trigger tb_Task_Trigger_insert
on tb_Task
after insert
as
insert into tb_Task_History(TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, 
							DateClosed,DateChanged,TimeChanged,ResponsibleChange,OperationType)
select TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, DateClosed, 
	   cast(getdate() as date) as DateChanged,
	   cast(getdate() as time) as TimeChanged,
	   system_user,
	   'insert' as OperationType
from inserted
go

create trigger tb_Task_Trigger_update
on tb_Task
after update
as
insert into tb_Task_History(TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, 
							DateClosed,DateChanged,TimeChanged,ResponsibleChange,OperationType)
select TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, DateClosed, 
	   cast(getdate() as date) as DateChanged,
	   cast(getdate() as time) as TimeChanged,
	   system_user,
	   'update - new rows' as OperationType
from inserted

insert into tb_Task_History(TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, 
							DateClosed,DateChanged,TimeChanged,ResponsibleChange,OperationType)
select TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, DateClosed, 
	   cast(getdate() as date) as DateChanged,
	   cast(getdate() as time) as TimeChanged,
	   system_user,
	   'update - existing rows' as OperationType
from deleted
go

create trigger tb_Task_Trigger_delete
on tb_Task
after delete
as
insert into tb_Task_History(TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, 
							DateClosed,DateChanged,TimeChanged,ResponsibleChange,OperationType)
select TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, DateClosed, 
	   cast(getdate() as date) as DateChanged,
	   cast(getdate() as time) as TimeChanged,
	   system_user,
	   'delete' as OperationType
from deleted
go

insert into tb_Task(TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, DateClosed)
values
(1,1,1,4,'TaskQ','2015-1-14','2017-10-10','2017-6-8'),
(2,1,5,4,'TaskW','2015-1-14','2017-10-10','2017-9-16'),
(3,1,12,4,'TaskE','2015-1-14','2017-10-10','2017-12-25'),
(4,1,19,4,'TaskE','2015-1-14','2018-1-18','2018-4-4'),
(5,1,24,4,'TaskR','2015-1-14','2018-1-18','2018-4-4'),
(6,2,1,1,'TaskT','2015-1-15','2018-1-19',null),
(7,2,4,2,'TaskY','2015-1-15','2018-1-19',null),
(8,2,10,3,'TaskU','2015-1-15','2018-1-19',null),
(9,2,11,4,'TaskI','2015-1-15','2018-1-19','2017-10-11'),
(10,2,18,3,'TaskO','2015-1-15','2018-1-19',null),
(11,3,3,4,'TaskP','2015-1-17','2018-1-21','2017-10-13'),
(12,3,5,4,'TaskA','2015-1-17','2018-1-21','2017-10-13'),
(13,3,5,4,'TaskS','2015-1-14','2018-1-18','2017-10-10'),
(14,3,9,4,'TaskD','2015-1-14','2018-1-18','2018-8-6'),
(15,3,10,4,'TaskF','2015-1-14','2018-1-18','2018-8-6'),
(16,4,1,3,'TaskG','2018-5-4','2021-5-8',null),
(17,4,2,3,'TaskH','2018-5-4','2021-5-8',null),
(18,4,5,3,'TaskJ','2018-5-4','2021-5-8',null),
(19,4,8,1,'TaskK','2018-9-6','2021-9-10',null),
(20,4,10,4,'TaskL','2021-2-1','2024-2-6','2021-5-12'),
(21,5,1,4,'TaskZ','2021-2-1','2024-2-6','2021-5-22'),
(22,5,6,3,'TaskX','2021-2-1','2024-2-6',null),
(23,5,7,3,'TaskC','2019-7-3','2022-7-7',null),
(24,5,10,1,'TaskV','2019-7-3','2022-7-7',null),
(25,5,14,1,'TaskB','2020-5-1','2023-5-6',null),
(26,5,15,1,'TaskN','2020-5-1','2023-5-6',null),
(27,5,20,1,'TaskM','2020-5-1','2023-5-6',null)
;
go

insert into tb_Task(TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, DateClosed)
values
(28,1,1,4,'TaskSSD','2015-1-14','2017-10-10','2017-6-8');

update tb_Task
set DateClosed = '2017-06-07'
from tb_Task
where TaskId = 28;

delete from tb_Task where TaskId = 28;
go

create view vw_Employee
as
select				
	EmployeeId,
	FirstName + ' ' + MiddleName + ' ' + LastName as EmployeeName,
	StartDate,
	EndDate,
	case when EndDate is not null 
		 then 'Fired'
		 else 'Working'
	end as "Status"
from tb_Employee
go

select * from tb_Project;
select * from tb_Task;
select * from vw_Employee;
select * from tb_Project_Status;
select * from tb_Task_Status;
select * from tb_Role;
select * from tb_Task_History;
select * from tb_RoleEmpl;