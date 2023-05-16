USE `soft_uni`;

DELIMITER $$

# 10. Future Value Function

CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19, 4), yearly_rate DOUBLE, years INT)
RETURNS DECIMAL (19, 4)
DETERMINISTIC
BEGIN
	DECLARE futute_value DECIMAL(19, 4);
    
    SET futute_value := sum * POW(1 + yearly_rate, years);
    
    RETURN futute_value;
	
END$$

SELECT ufn_calculate_future_value (1000, 0.5, 5)$$