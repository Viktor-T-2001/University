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
from tb_Employee;