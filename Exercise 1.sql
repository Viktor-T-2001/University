use DoctorWho;

select c.CompanionName
from tblCompanion c
left join tblEpisodeCompanion ec
	on ec.CompanionId = c.CompanionId
where ec.CompanionId is null;