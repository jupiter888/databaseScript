--Daniel Tracy



Use MetroAlt

--1.
Select PositionName[Position], count(PositionKey) as[Count]
From 
(
Select p.PositionName, p.Positionkey 
From Position p
INNER JOIN EmployeePosition ep
on p.PositionKey=ep.PositionKey
) as [Position]
group by  PositionName



--2.
Select YEAR(EmployeeHireDate) as [Hire Year], count(PositionKey) as[Count]
From 
(
Select e.EmployeeHireDate, p.Positionkey 
From EmployeePosition p
INNER JOIN Employee e
on p.EmployeeKey=e.EmployeeKey
) as [Position]
group by  YEAR(EmployeeHireDate)



--3
GO 
With Positions as
(
Select PositionName[Positions],
count(ep.PositionKey) as[Count]
From Position p
INNER JOIN EmployeePosition ep
on p.PositionKey=ep.PositionKey
group by  PositionName
) 
Select [Positions], [Count] from Positions
 


--4.
GO 
With HireCounts as
(
Select YEAR(EmployeeHireDate)as [Hire Year],
 count(PositionKey) as[Count]
From EmployeePosition p
INNER JOIN Employee e
on p.EmployeeKey=e.EmployeeKey
Group By YEAR(EmployeeHireDate)
) 
Select [Hire Year], [Count] from HireCounts
 


 
--5
Go
Declare @BusBarn int 
set @BusBarn=3;
with BarnCount as
(
Select 
bt.BusTypeKey [Bus type],
BusBarnKey[Bus Barn],
BusTypeDescription[Bus Description]
From Bus b
INNER JOIN BusType bt
on b.BusTypekey=bt.BusTypeKey
where b.BusBarnKey=@BusBarn
)
Select [Bus Description], count([Bus type]) as [Count]
from BarnCount
Group by [Bus Description]




--6 
CREATE View dbo.EmployeePayy
AS 
Select EmployeeLastName[Last],
EmployeeFirstName[First],
EmployeeEmail [Email],
EmployeePhone [Phone],
EmployeeAddress [Address],
EmployeeCity [City],
EmployeeZipCode [Zip Code],
EmployeeHireDate [Hire Date],
EmployeeHourlyPayRate [Pay Rate]

From Employee e
INNER JOIN EmployeePosition ep
on e.EmployeeKey=ep.EmployeeKey
GO
SELECT [Last],[First],[Phone],[Email],[City],[Address],[Zip Code],[Hire Date],[Pay Rate]  From dbo.EmployeePayy




--7.
ALTER View dbo.EmployeePayy with Schemabinding
AS 
Select EmployeeLastName[Last],
EmployeeFirstName[First],
EmployeeEmail [Email],
EmployeePhone [Phone],
EmployeeAddress [Address],
EmployeeCity [City],
EmployeeZipCode [Zip Code],
EmployeeHireDate [Hire Date],
EmployeeHourlyPayRate [Pay Rate]
From dbo.Employee e
INNER JOIN dbo.EmployeePosition ep
on e.EmployeeKey=ep.EmployeeKey




--8.
CREATE View dbo.ScheduleAssignment3
AS 
Select EmployeeLastName[Last],
EmployeeFirstName[First],
bsa.BusRouteKey[Route Key],
BusDriverShiftStartTime[Start],
BusDriverShiftStopTime [Stop],
Month(BusScheduleAssignmentDate) [Month],
Year(BusScheduleAssignmentDate) [Year],
Day(BusScheduleAssignmentDate) [Day],
BusKey [Bus Key]
From Employee e
INNER JOIN BusScheduleAssignment bsa
on e.EmployeeKey=bsa.EmployeeKey
INNER JOIN BusRoute br
on bsa.BusRouteKey=br.BusRouteKey
INNER JOIN BusDriverShift bds
on bsa.BusDriverShiftKey=bds.BusDriverShiftKey
GO
SELECT distinct [Last],[First],[Route Key],[Bus Key],[Day],[Month],[Year],[Start],[Stop] From dbo.ScheduleAssignment3
where [Last]='Pangle' and [First]='Neil' and [Month]= 10 and [Year]=2014




--9.
Create function fx_City888
(@City nvarchar(255)) 
--@employeeCity is simply a name-- this is the perimeter getting passed in , use: nvarchar(255)
returns Table
As
Return
Select EmployeeLastName, EmployeeFirstName, EmployeeCity
From Employee
Where EmployeeCity = @City
Go
-- where a place in the table, = the input from the user during query such as below
Select * from fx_City888('Seattle') --takes arguement, this is int, we will use nvarchar





--10.
select distinct EmployeeKey, brk
From dbo.BusScheduleAssignment a
cross apply
(Select EmployeeKey ek, BusRouteKey brk
From BusScheduleAssignment as bsa
where a.BusRouteKey=bsa.BusRouteKey 
Order by BusRouteKey desc
offset 0 rows fetch first 3 rows only) as c
order by EmployeeKey




