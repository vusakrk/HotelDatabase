CREATE DATABASE HotelManage
use hotelmanage

CREATE TABLE HotelstarRate(
StarRateId int primary key,
Name nvarchar(50) not null,
Rating nvarchar (50),
)
 drop table HotelstarRate
CREATE TABLE Hotels(
HotelId int identity primary key,
HotelName nvarchar(50) not null,
HotelDescription nvarchar(200) not null,
RoomsNumber int not null,
FullRom int,
AvailableRoom int,
FloorsQuantity int not null,
HotelAddress nvarchar(150),
HotelCity nvarchar(50) not null,
HotelCountry nvarchar(50),
HotelPhone nvarchar(50),
StarRateId int foreign key references HotelStarRate(StarRateId)
)
drop table hotels
CREATE TABLE RoomType(
RoomTypeId int primary key,
RoomTypeName nvarchar (50),
RoomTypeDescription nvarchar(200) not null,
RoomTypeRate decimal(6,2) not null,
RoomCapacity int not null,
)


CREATE TABLE Discount (
DiscountId int primary key,
DiscountPeriod nvarchar (45) not null,
DiscountPercent int not null
)

CREATE TABLE Rooms(
RoomId int primary key,
RoomName nvarchar (50) not null,
AvailableRoom int not null,
HotelsId int FOREIGN KEY References Hotels(HotelId),
RoomTypeId int Foreign KEY references RoomType(RoomTypeId),
DiscountId int Foreign KEY references Discount(DiscountId)
)

CREATE TABLE Payment(
PaymentId int primary key,
PaymentMethodName nvarchar (50) not null,
)

CREATE TABLE Guests(
GuestId int primary key,
GuestName nvarchar(50) not null,
GuestAddress nvarchar (150) not null,
GuestCity nvarchar (50) not null,
GuestCountry nvarchar (50) not null,
GuestPhone int not null,
GuestEmail nvarchar (50) not null
)

CREATE TABLE HotelLog(
HotelLogId int primary key,
HotelLogType nvarchar (50) not null,
HotelLogDate Datetime not null,
CheckDate Datetime not null,
PaymentId int foreign key references Payment(PaymentId),
RoomId int foreign key references Rooms(RoomId),
HotelId int foreign key references Hotels(HotelId),
GuestId int foreign key references Guests(GuestId)
)



CREATE TABLE Services(
ServiceId int  NOT NULL primary key,
ServiceName nvarchar(50) not null,
ServiceDesc nvarchar (50) not null,
ServiceCost nvarchar(50) not null
)
 
 CREATE TABLE RoomServices(
RoomId int Foreign key references Rooms(RoomId),
ServiceId int Foreign Key references Services(ServiceId)
)

CREATE TABLE Employee(
EmployeeId int primary key identity,
EmployeeName nvarchar(50) not null,
EmployeeSurname nvarchar(50),
Age int not null,
WorkHours int not null,
EmployeePhone nvarchar (45),
BirthDate Date Not null,
gender nvarchar(1) not null,
RoleId int foreign key references Role(RoleId),
HotelId int foreign key references Hotels(HotelId)
)
drop table Employee

CREATE TABLE Role (
RoleId int identity primary key,
RoleName nvarchar (50),
RoleSalary int not null
)
  INSERT INTO Role 
  VALUES
  ('Manager','2000'),
  ('Receptionist','1500')

drop table role
SET ANSI_WARNINGS OFF;






INSERT INTO HotelLog
VALUES
(1,'Offline',GETDATE(),'2021-08-23 12:37:57',6,1,5,1),
(2,'Online',GETDATE(),'2021-08-21 11:57:38',6,1,5,1),
(3,'Online',GETDATE(),'2021-07-19 07:35:17',6,1,5,1),
(4,'Offline',GETDATE(),'2021-06-23 03:52:08',6,1,5,1),
(5,'Online',GETDATE(),'2021-03-18 23:59:00',6,1,5,1)

INSERT INTO Rooms 
values
(1,'1A101',0,14,1,3);

CREATE VIEW Discount_Periods
AS
SELECT 
Discount.DiscountPeriod,RoomType.RoomTypeRate
AS
ActualRate,(RoomType.RoomTypeRate * (Discount.DiscountPercent/100))
AS
AfterDiscount From Discount join Rooms
ON
Discount.DiscountId=Rooms.DiscountId
JOIN RoomType
ON
Rooms.RoomTypeId=RoomType.RoomTypeId
SELECT * FROM Discount_Periods;




CREATE VIEW
TrackGuest 
AS
SELECT GuestName
AS
GuestName,GuestAddress
AS
GuestAddress,GuestCity
AS
City
FROM Guests

SELECT * FROM TrackGuest

CREATE VIEW DiscountPer 
AS
SELECT Discount.DiscountPeriod,RoomType.RoomTypeDescription
AS
ActualRate,(RoomType.RoomTypeRate * (Discount.DiscountPercent/100)) AS AfterDiscount
FROM Discount
JOIN Rooms
ON Discount.DiscountId=Rooms.DiscountId
JOIN RoomType
on Rooms.RoomTypeId=RoomType.RoomTypeId
group by Discount.DiscountPeriod;

SELECT * from HotelLog;



