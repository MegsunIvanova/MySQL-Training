USE `soft_uni`;

DELIMITER $$

# 10. Future Value Function

CREATE FUNCTION ufn_calculate_future_value (
	initial_sum DECIMAL(65, 4), 
    yearly_interest_rate DOUBLE, 
    number_of_years INT
)
RETURNS DECIMAL(65, 4)
DETERMINISTIC
BEGIN
	DECLARE futute_value DECIMAL(65, 4);
    
    SET futute_value := initial_sum * (POW((1+yearly_interest_rate), number_of_years));
    
    RETURN futute_value;
	
END$$

SELECT ufn_calculate_future_value (1000, 0.5, 5)$$