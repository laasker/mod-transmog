-- Convert the account-wide transmog collection to per-character ownership.
-- Preserve existing unlocks by copying each account's collection to all of its characters.
CREATE TABLE `custom_unlocked_appearances_character` (
    `character_guid` int(10) unsigned NOT NULL,
    `item_template_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`character_guid`, `item_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM `custom_unlocked_appearances_character`;
INSERT INTO `custom_unlocked_appearances_character` (`character_guid`, `item_template_id`)
SELECT `characters`.`guid`, `custom_unlocked_appearances`.`item_template_id`
FROM `characters`
INNER JOIN `custom_unlocked_appearances`
    ON `characters`.`account` = `custom_unlocked_appearances`.`account_id`;

RENAME TABLE
    `custom_unlocked_appearances` TO `custom_unlocked_appearances_account_backup`,
    `custom_unlocked_appearances_character` TO `custom_unlocked_appearances`;
