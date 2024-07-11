-- Compute and store the average score for a student.
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;

DELIMITER $$

CREATE PROCEDURE ComputeAverageScoreForUser(IN input_user_id INT)
BEGIN
  DECLARE result DECIMAL(8,2) DEFAULT 0.0;
  SELECT AVG(score) INTO result
  FROM corrections
  WHERE user_id = input_user_id;
  UPDATE users SET average_score = result WHERE id = input_user_id;
END
$$