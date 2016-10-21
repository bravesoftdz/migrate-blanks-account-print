DROP PROCEDURE ADD_UPDATE_SERVICE;
SET TERM ^ ;

CREATE PROCEDURE ADD_UPDATE_SERVICE(
  IN_SERVICE_ID INTEGER,
  IN_SERVICE_NAME VARCHAR(255) CHARACTER SET UTF8 COLLATE UTF8,
  IN_SERVICE_CODE INTEGER,
  IN_SERVICE_PRICE DECIMAL(12, 2))
RETURNS(
  OUT_SERVICE_ID INTEGER)
AS
DECLARE VARIABLE SCOUNT INTEGER;
BEGIN
  /* Procedure body */
  IF (IN_SERVICE_ID IS NULL) THEN
  BEGIN
  	OUT_SERVICE_ID = GEN_ID(SERVICES_SERVICE_ID_GEN, 1);
  	
    SELECT COUNT(*)
    FROM SERVICES
    INTO :SCOUNT;
    
    IF (SCOUNT=0) THEN
    BEGIN
    	IN_SERVICE_CODE=1;
    END
    
    IF (IN_SERVICE_CODE IS NULL) THEN
    BEGIN
    	SELECT MAX(SERVICE_CODE)+1 
        FROM SERVICES
        INTO :IN_SERVICE_CODE;
    END
    
    INSERT INTO SERVICES(SERVICE_ID, SERVICE_NAME, 
    SERVICE_CODE, SERVICE_PRICE)
    VALUES (:OUT_SERVICE_ID, :IN_SERVICE_NAME, 
    :IN_SERVICE_CODE, :IN_SERVICE_PRICE);
  END
  SUSPEND;
END^

SET TERM ; ^