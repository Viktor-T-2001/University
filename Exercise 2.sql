use WorldEvents;

SELECT
	e.EventName,
	e.EventDate,
	c.CountryName
FROM tblEvent e 
LEFT JOIN tblCountry c
	ON c.CountryId = e.CountryId
WHERE
e.EventDate > (
SELECT MAX(EventDate)
FROM tblEvent 
WHERE CountryId = 21
)
ORDER BY e.EventDate DESC;