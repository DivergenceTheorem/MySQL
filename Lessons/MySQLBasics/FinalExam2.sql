USE lesson_4;

-- Задание #1: 

DROP PROCEDURE IF EXISTS sec_transfer;
DELIMITER //
CREATE PROCEDURE sec_transfer(IN seconds INT(10))
BEGIN
	SET @days = ROUND(seconds / 86400, 0);
    SET seconds = seconds - @days * 86400;
    SET @hours = ROUND( seconds / 3600 , 0);
    SET seconds = seconds - @hours * 3600;
    SET @minutes = ROUND( seconds / 60, 0);
    SET seconds = seconds - @minutes * 60;
    SELECT @days AS 'days', @hours AS 'hours', @minutes AS 'minutes', seconds AS 'seconds';
END //

CALL sec_transfer(120012); 

-- Задание #2:

WITH RECURSIVE sequence (n) AS
(
    SELECT 2
    UNION ALL
    SELECT n+2
    FROM sequence
    WHERE n+2 <= 10
)
SELECT n
FROM sequence;



