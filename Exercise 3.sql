use WorldEvents;

select c.CountryName
from tblCountry c
where 8 < (
select count(*)
from tblEvent e
where e.CountryId = c.CountryId
)
order by c.CountryName asc;
