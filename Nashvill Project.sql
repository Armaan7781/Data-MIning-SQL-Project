
-- Cleaning data in SQL
select *
from [Portfolio Projects]..[NashvillHousing]

-------------------------------------------------------------------------------------

-- Standardize Date Format


alter table [PORTFOLIO Project ]..Nashvillhousing 
add [Sale Date] date;

update [PORTFOLIO Project ]..Nashvillhousing 
set [Sale Date] = Convert(Date,SaleDate)

Select [Sale Date]
from [PORTFOLIO Project ]..Nashvillhousing  


-------------------------------------------------------------------------------------------------

-- Populate Property Address Data 

Select *
from [PORTFOLIO Project ]..Nashvillhousing
--where PropertyAddress is null
order by ParcelID

Select A.ParcelID,A.PropertyAddress,B.ParcelID, B.PropertyAddress, ISNULL(A.PropertyAddress,B.PropertyAddress)
from [PORTFOLIO Project ]..Nashvillhousing A
JOIN [PORTFOLIO Project ]..Nashvillhousing B
	ON A.ParcelID = B.ParcelID
	AND A.UniqueID <> B.UniqueID
Where A.PropertyAddress is null

update A
set propertyaddress = ISNULL(A.PropertyAddress,B.PropertyAddress)
from [PORTFOLIO Project ]..Nashvillhousing A
JOIN [PORTFOLIO Project ]..Nashvillhousing B
	ON A.ParcelID = B.ParcelID
	AND A.UniqueID <>B.UniqueID

--------------------------------------------------------------------------------

-- Bereaking out address into individual columns (Address, City, State)

Select PropertyAddress
from [Portfolio Project]..NashvillHousing

select 
substring(PropertyAddress, 1, charindex(',',PropertyAddress)-1) as Address,
substring(PropertyAddress,charindex(',',PropertyAddress)+1, len(PropertyAddress))as Address
from [Portfolio Project]..NashvillHousing



alter table [PORTFOLIO Project ]..Nashvillhousing 
add [Property Split Address] nvarchar (255);

update [PORTFOLIO Project ]..Nashvillhousing 
set [Property Split Address] = substring(PropertyAddress,charindex(',',PropertyAddress)-1, len(PropertyAddress))


alter table [PORTFOLIO Project ]..Nashvillhousing 
add [Property Split City] nvarchar(255);

update [PORTFOLIO Project ]..Nashvillhousing 
set [Property Split City] = substring(PropertyAddress,charindex(',',PropertyAddress)+1, len(PropertyAddress))


Select [Property Split City],[Property Split Address]
from [PORTFOLIO Project ]..Nashvillhousing 