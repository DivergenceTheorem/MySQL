USE lesson_4;

#Создаем таблицу old_users
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE
);
# Создаем процедуру для переноса пользователя из users в users_old
# Если будет указан корректный e-mail, то делаем Commit
# Если e-mail не существует, то делаем Rollback
DELIMITER //
CREATE PROCEDURE transfer_user(IN email_search VARCHAR(120))
BEGIN
	DECLARE `_rollback` BIT DEFAULT b'0';
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		SET `_rollback` = 1;
    END;
    
    START TRANSACTION;
    
	INSERT INTO users_old
    SELECT id, firstname, lastname, email 
    FROM users
    WHERE email = email_search;
    
    IF `_rollback` THEN
		ROLLBACK;
	ELSE 
		COMMIT;
	END IF;
    
END
//

CALL transfer_user('arlo50@exaqwemple.org');

#---Второе задание---
DROP PROCEDURE IF EXISTS hello;
DELIMITER //
CREATE PROCEDURE hello()
BEGIN
    SET @dt = CURRENT_TIME();
    
    IF @dt < '06:00:00' THEN 
		SELECT 'Доброй ночи';
	  ELSEIF @dt > '06:00:00' AND @dt < '12:00:00' THEN 
		SELECT 'Доброго утра'; 
    ELSEIF @dt > '12:00:00' AND @dt < '18:00:00' THEN
		SELECT 'Доброго дня'; 
    ELSE
		SELECT 'Доброго вечера'; 
	END IF;
END
//

CALL hello;
