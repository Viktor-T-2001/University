use HomeworkDB;
go 

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

insert into tb_Task(TaskId, ProjectId, EmployeeId, TaskStatusId, "Name", DateCreated, DateExpected, DateClosed)
values
(28,1,1,4,'TaskSSD','2015-1-14','2017-10-10','2017-6-8');

update tb_Task
set DateClosed = '2017-06-07'
from tb_Task
where TaskId = 28;

delete from tb_Task where TaskId = 28;