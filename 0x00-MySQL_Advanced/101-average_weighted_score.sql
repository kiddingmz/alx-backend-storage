-- Calculate average weighted score for all users
DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN in_user_id INT)
BEGIN
  DECLARE sum_weight INT;
  DECLARE sum_score_weight DOUBLE;
  SELECT SUM(weight) INTO sum_weight
  FROM corrections
    JOIN projects
      WHERE id = project_id AND user_id = in_user_id;
  SELECT SUM(score * weight) INTO sum_score_weight
  FROM corrections
    JOIN projects
      WHERE id = project_id AND user_id = in_user_id;
  UPDATE users
    SET average_score = sum_score_weight / sum_weight
    WHERE id = in_user_id;
END$$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE userId INT;
  DECLARE cur CURSOR FOR SELECT id FROM users;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;

  compute_loop: LOOP
    FETCH cur INTO userId;
    IF done THEN
      LEAVE compute_loop;
    END IF;

    CALL ComputeAverageWeightedScoreForUser(userId);

  END LOOP;

  CLOSE cur;
END$$

DELIMITER ;