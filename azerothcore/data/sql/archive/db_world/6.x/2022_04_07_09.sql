-- DB update 2022_04_07_08 -> 2022_04_07_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_07_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_07_08 2022_04_07_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648996451912542300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648996451912542300');

DELETE FROM `spell_script_names` WHERE `spell_id`=22247;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(22247,'spell_suppression_aura');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_07_09' WHERE sql_rev = '1648996451912542300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
