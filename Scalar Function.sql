use HotelManage

CREATE FUNCTION GetHotels(@StarRateId int)
RETURNS nvarchar (50)
BEGIN
    DECLARE @Result nvarchar(200)
	SELECT @Result= Hotels.HotelName
	FROM Hotels 
	WHERE StarRateId=@StarRateId
	RETURN @Result
	END
	SELECT dbo.GetHotels(2);
