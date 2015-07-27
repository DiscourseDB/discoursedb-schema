-- MySQL Script generated by MySQL Workbench
-- Mon Jul 27 15:10:34 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema discoursedb_v02
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `discoursedb_v02` ;

-- -----------------------------------------------------
-- Schema discoursedb_v02
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `discoursedb_v02` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `discoursedb_v02` ;

-- -----------------------------------------------------
-- Table `discoursedb_v02`.`annotation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`annotation` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`annotation` (
  `id_annotation` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_annotation`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`discourse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`discourse` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`discourse` (
  `id_discourse` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_annotation` BIGINT UNSIGNED NULL,
  `name` VARCHAR(200) NOT NULL,
  `source` VARCHAR(200) NULL,
  PRIMARY KEY (`id_discourse`),
  CONSTRAINT `fk_Discourse_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Discourse_Annotation1_idx` ON `discoursedb_v02`.`discourse` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`discourse_part_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`discourse_part_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`discourse_part_type` (
  `id_discourse_part_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`id_discourse_part_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`discourse_part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`discourse_part` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`discourse_part` (
  `id_discourse_part` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_discourse_part_type` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(200) NULL,
  `start_time` DATETIME NULL COMMENT '	',
  `end_time` DATETIME NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id_discourse_part`, `fk_discourse_part_type`),
  CONSTRAINT `fk_DiscoursePart_DiscoursePart_Type1`
    FOREIGN KEY (`fk_discourse_part_type`)
    REFERENCES `discoursedb_v02`.`discourse_part_type` (`id_discourse_part_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DiscoursePart_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DiscoursePart_DiscoursePart_Type1_idx` ON `discoursedb_v02`.`discourse_part` (`fk_discourse_part_type` ASC);

CREATE INDEX `fk_DiscoursePart_Annotation1_idx` ON `discoursedb_v02`.`discourse_part` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`content` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`content` (
  `id_content` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creation_time` DATETIME NULL,
  `fk_content_previous_revision` BIGINT UNSIGNED NULL,
  `fk_content_next_revision` BIGINT UNSIGNED NULL,
  `text` TEXT NULL,
  `data` BLOB NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id_content`),
  CONSTRAINT `fk_Revision_Revision1`
    FOREIGN KEY (`fk_content_previous_revision`)
    REFERENCES `discoursedb_v02`.`content` (`id_content`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Revision_Revision2`
    FOREIGN KEY (`fk_content_next_revision`)
    REFERENCES `discoursedb_v02`.`content` (`id_content`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Content_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Revision_Revision1_idx` ON `discoursedb_v02`.`content` (`fk_content_previous_revision` ASC);

CREATE INDEX `fk_Revision_Revision2_idx` ON `discoursedb_v02`.`content` (`fk_content_next_revision` ASC);

CREATE INDEX `fk_Content_Annotation1_idx` ON `discoursedb_v02`.`content` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`contribution_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`contribution_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`contribution_type` (
  `id_contribution_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(200) NULL,
  PRIMARY KEY (`id_contribution_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`contribution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`contribution` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`contribution` (
  `id_contribution` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_content_first_revision` BIGINT UNSIGNED NOT NULL,
  `fk_content_current_revision` BIGINT UNSIGNED NOT NULL,
  `fk_contribution_type` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id_contribution`),
  CONSTRAINT `fk_Contribution_Revision1`
    FOREIGN KEY (`fk_content_current_revision`)
    REFERENCES `discoursedb_v02`.`content` (`id_content`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contribution_Revision3`
    FOREIGN KEY (`fk_content_first_revision`)
    REFERENCES `discoursedb_v02`.`content` (`id_content`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contribution_Contribution_Type1`
    FOREIGN KEY (`fk_contribution_type`)
    REFERENCES `discoursedb_v02`.`contribution_type` (`id_contribution_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contribution_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Contribution_Revision1_idx` ON `discoursedb_v02`.`contribution` (`fk_content_current_revision` ASC);

CREATE INDEX `fk_Contribution_Revision3_idx` ON `discoursedb_v02`.`contribution` (`fk_content_first_revision` ASC);

CREATE INDEX `fk_Contribution_Contribution_Type1_idx` ON `discoursedb_v02`.`contribution` (`fk_contribution_type` ASC);

CREATE INDEX `fk_Contribution_Annotation1_idx` ON `discoursedb_v02`.`contribution` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`discourse_relation_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`discourse_relation_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`discourse_relation_type` (
  `id_discourse_relation_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(200) NULL,
  PRIMARY KEY (`id_discourse_relation_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`discourse_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`discourse_relation` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`discourse_relation` (
  `id_discourse_relation` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_contribution_source` BIGINT UNSIGNED NOT NULL,
  `fk_contribution_target` BIGINT UNSIGNED NOT NULL,
  `fk_discourse_relation_type` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id_discourse_relation`),
  CONSTRAINT `fk_Reply_Contribution1`
    FOREIGN KEY (`fk_contribution_source`)
    REFERENCES `discoursedb_v02`.`contribution` (`id_contribution`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reply_Contribution2`
    FOREIGN KEY (`fk_contribution_target`)
    REFERENCES `discoursedb_v02`.`contribution` (`id_contribution`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reply_Reply_Type1`
    FOREIGN KEY (`fk_discourse_relation_type`)
    REFERENCES `discoursedb_v02`.`discourse_relation_type` (`id_discourse_relation_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DiscourseRelation_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Reply_Contribution1_idx` ON `discoursedb_v02`.`discourse_relation` (`fk_contribution_source` ASC);

CREATE INDEX `fk_Reply_Contribution2_idx` ON `discoursedb_v02`.`discourse_relation` (`fk_contribution_target` ASC);

CREATE INDEX `fk_Reply_Reply_Type1_idx` ON `discoursedb_v02`.`discourse_relation` (`fk_discourse_relation_type` ASC);

CREATE INDEX `fk_DiscourseRelation_Annotation1_idx` ON `discoursedb_v02`.`discourse_relation` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`discourse_part_relation_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`discourse_part_relation_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`discourse_part_relation_type` (
  `id_discourse_part_relation_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(200) NULL,
  PRIMARY KEY (`id_discourse_part_relation_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`discourse_part_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`discourse_part_relation` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`discourse_part_relation` (
  `id_discourse_part_relation` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_source_discourse_part` BIGINT UNSIGNED NOT NULL,
  `fk_target_discourse_part` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  `fk_discourse_part_relation_type` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_discourse_part_relation`),
  CONSTRAINT `fk_Embedding_DiscoursePart1`
    FOREIGN KEY (`fk_source_discourse_part`)
    REFERENCES `discoursedb_v02`.`discourse_part` (`id_discourse_part`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Embedding_DiscoursePart2`
    FOREIGN KEY (`fk_target_discourse_part`)
    REFERENCES `discoursedb_v02`.`discourse_part` (`id_discourse_part`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Embedding_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DiscoursePart_Relation_DiscoursePart_Relation_Type1`
    FOREIGN KEY (`fk_discourse_part_relation_type`)
    REFERENCES `discoursedb_v02`.`discourse_part_relation_type` (`id_discourse_part_relation_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Embedding_DiscoursePart1_idx` ON `discoursedb_v02`.`discourse_part_relation` (`fk_source_discourse_part` ASC);

CREATE INDEX `fk_Embedding_DiscoursePart2_idx` ON `discoursedb_v02`.`discourse_part_relation` (`fk_target_discourse_part` ASC);

CREATE INDEX `fk_Embedding_Annotation1_idx` ON `discoursedb_v02`.`discourse_part_relation` (`fk_annotation` ASC);

CREATE INDEX `fk_DiscoursePart_Relation_DiscoursePart_Relation_Type1_idx` ON `discoursedb_v02`.`discourse_part_relation` (`fk_discourse_part_relation_type` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`feature_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`feature_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`feature_type` (
  `id_feat_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  `datatype` VARCHAR(200) NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id_feat_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`annotation_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`annotation_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`annotation_type` (
  `id_annotation_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  `isEntityAnnotation` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_annotation_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`discoursedb`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`discoursedb` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`discoursedb` (
  `id_discoursedb` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `schema_version` VARCHAR(200) NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL,
  PRIMARY KEY (`id_discoursedb`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`annotation_instance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`annotation_instance` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`annotation_instance` (
  `id_annotation_instance` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `begin_offset` INT NULL,
  `end_offset` INT NULL,
  `covered_text` TEXT NULL,
  `fk_annotation` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_annotation_type` BIGINT UNSIGNED NOT NULL,
  `fk_discoursedb` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_annotation_instance`),
  CONSTRAINT `fk_Annotation_Instance_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Annotation_Instance_Annotation_Type1`
    FOREIGN KEY (`fk_annotation_type`)
    REFERENCES `discoursedb_v02`.`annotation_type` (`id_annotation_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Annotation_Instance_DiscourseDB1`
    FOREIGN KEY (`fk_discoursedb`)
    REFERENCES `discoursedb_v02`.`discoursedb` (`id_discoursedb`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Annotation_Instance_Annotation1_idx` ON `discoursedb_v02`.`annotation_instance` (`fk_annotation` ASC);

CREATE INDEX `fk_Annotation_Instance_Annotation_Type1_idx` ON `discoursedb_v02`.`annotation_instance` (`fk_annotation_type` ASC);

CREATE INDEX `fk_Annotation_Instance_DiscourseDB1_idx` ON `discoursedb_v02`.`annotation_instance` (`fk_discoursedb` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`feature_instance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`feature_instance` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`feature_instance` (
  `id_feat_inst` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_feat_type` BIGINT UNSIGNED NOT NULL,
  `value` TEXT NULL,
  `fk_annotation_instance` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_feat_inst`),
  CONSTRAINT `fk_Feature_Inst_Feature_Type1`
    FOREIGN KEY (`fk_feat_type`)
    REFERENCES `discoursedb_v02`.`feature_type` (`id_feat_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Feature_Annotation_Instance1`
    FOREIGN KEY (`fk_annotation_instance`)
    REFERENCES `discoursedb_v02`.`annotation_instance` (`id_annotation_instance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Feature_Inst_Feature_Type1_idx` ON `discoursedb_v02`.`feature_instance` (`fk_feat_type` ASC);

CREATE INDEX `fk_Feature_Annotation_Instance1_idx` ON `discoursedb_v02`.`feature_instance` (`fk_annotation_instance` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`user` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`user` (
  `id_user` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `realname` VARCHAR(200) NULL,
  `username` VARCHAR(200) NULL,
  `email` VARCHAR(200) NULL,
  `location` VARCHAR(200) NULL,
  `language` VARCHAR(200) NULL,
  `ip` VARCHAR(200) NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id_user`),
  CONSTRAINT `fk_User_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_User_Annotation1_idx` ON `discoursedb_v02`.`user` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`group_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`group_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`group_type` (
  `id_group_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(200) NULL,
  PRIMARY KEY (`id_group_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`group` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`group` (
  `id_group` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  `start_time` DATETIME NOT NULL COMMENT '	',
  `end_time` DATETIME NULL,
  `fk_group_type` BIGINT UNSIGNED NOT NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id_group`),
  CONSTRAINT `fk_Group_Group_Type1`
    FOREIGN KEY (`fk_group_type`)
    REFERENCES `discoursedb_v02`.`group_type` (`id_group_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Group_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Group_Group_Type1_idx` ON `discoursedb_v02`.`group` (`fk_group_type` ASC);

CREATE INDEX `fk_Group_Annotation1_idx` ON `discoursedb_v02`.`group` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`user_memberof_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`user_memberof_group` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`user_memberof_group` (
  `fk_user` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_group` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`fk_user`, `fk_group`),
  CONSTRAINT `fk_User_has_Group_User1`
    FOREIGN KEY (`fk_user`)
    REFERENCES `discoursedb_v02`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Group_Group1`
    FOREIGN KEY (`fk_group`)
    REFERENCES `discoursedb_v02`.`group` (`id_group`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_memberof_Group_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_User_has_Group_Group1_idx` ON `discoursedb_v02`.`user_memberof_group` (`fk_group` ASC);

CREATE INDEX `fk_User_has_Group_User1_idx` ON `discoursedb_v02`.`user_memberof_group` (`fk_user` ASC);

CREATE INDEX `fk_User_memberof_Group_Annotation1_idx` ON `discoursedb_v02`.`user_memberof_group` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`contribution_partOf_discourse_part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`contribution_partOf_discourse_part` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`contribution_partOf_discourse_part` (
  `fk_contribution` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_discourse_part` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`fk_contribution`, `fk_discourse_part`),
  CONSTRAINT `fk_Contribution_has_DiscoursePart_Contribution1`
    FOREIGN KEY (`fk_contribution`)
    REFERENCES `discoursedb_v02`.`contribution` (`id_contribution`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contribution_has_DiscoursePart_DiscoursePart1`
    FOREIGN KEY (`fk_discourse_part`)
    REFERENCES `discoursedb_v02`.`discourse_part` (`id_discourse_part`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contribution_partOf_DiscoursePart_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Contribution_has_DiscoursePart_DiscoursePart1_idx` ON `discoursedb_v02`.`contribution_partOf_discourse_part` (`fk_discourse_part` ASC);

CREATE INDEX `fk_Contribution_has_DiscoursePart_Contribution1_idx` ON `discoursedb_v02`.`contribution_partOf_discourse_part` (`fk_contribution` ASC);

CREATE INDEX `fk_Contribution_partOf_DiscoursePart_Annotation1_idx` ON `discoursedb_v02`.`contribution_partOf_discourse_part` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`discourse_has_discourse_part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`discourse_has_discourse_part` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`discourse_has_discourse_part` (
  `fk_discourse` BIGINT UNSIGNED NOT NULL,
  `fk_discourse_part` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`fk_discourse`, `fk_discourse_part`),
  CONSTRAINT `fk_Discourse_has_DiscoursePart_Discourse1`
    FOREIGN KEY (`fk_discourse`)
    REFERENCES `discoursedb_v02`.`discourse` (`id_discourse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Discourse_has_DiscoursePart_DiscoursePart1`
    FOREIGN KEY (`fk_discourse_part`)
    REFERENCES `discoursedb_v02`.`discourse_part` (`id_discourse_part`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Discourse_has_DiscoursePart_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Discourse_has_DiscoursePart_DiscoursePart1_idx` ON `discoursedb_v02`.`discourse_has_discourse_part` (`fk_discourse_part` ASC);

CREATE INDEX `fk_Discourse_has_DiscoursePart_Discourse1_idx` ON `discoursedb_v02`.`discourse_has_discourse_part` (`fk_discourse` ASC);

CREATE INDEX `fk_Discourse_has_DiscoursePart_Annotation1_idx` ON `discoursedb_v02`.`discourse_has_discourse_part` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`audience_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`audience_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`audience_type` (
  `id_audience_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(200) NULL,
  PRIMARY KEY (`id_audience_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`audience`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`audience` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`audience` (
  `id_audience` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_audience_type` BIGINT UNSIGNED NOT NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id_audience`),
  CONSTRAINT `fk_Audience_Audience_Type1`
    FOREIGN KEY (`fk_audience_type`)
    REFERENCES `discoursedb_v02`.`audience_type` (`id_audience_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Audience_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Audience_Audience_Type1_idx` ON `discoursedb_v02`.`audience` (`fk_audience_type` ASC);

CREATE INDEX `fk_Audience_Annotation1_idx` ON `discoursedb_v02`.`audience` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`audience_has_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`audience_has_user` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`audience_has_user` (
  `fk_audience` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_user` BIGINT UNSIGNED NOT NULL,
  `start_time` VARCHAR(45) NOT NULL,
  `end_time` VARCHAR(45) NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`fk_audience`, `fk_user`),
  CONSTRAINT `fk_Audience_has_User_Audience1`
    FOREIGN KEY (`fk_audience`)
    REFERENCES `discoursedb_v02`.`audience` (`id_audience`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Audience_has_User_User1`
    FOREIGN KEY (`fk_user`)
    REFERENCES `discoursedb_v02`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Audience_has_User_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Audience_has_User_User1_idx` ON `discoursedb_v02`.`audience_has_user` (`fk_user` ASC);

CREATE INDEX `fk_Audience_has_User_Audience1_idx` ON `discoursedb_v02`.`audience_has_user` (`fk_audience` ASC);

CREATE INDEX `fk_Audience_has_User_Annotation1_idx` ON `discoursedb_v02`.`audience_has_user` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`audience_has_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`audience_has_group` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`audience_has_group` (
  `fk_audience` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_group` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`fk_audience`, `fk_group`),
  CONSTRAINT `fk_Audience_has_Group_Audience1`
    FOREIGN KEY (`fk_audience`)
    REFERENCES `discoursedb_v02`.`audience` (`id_audience`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Audience_has_Group_Group1`
    FOREIGN KEY (`fk_group`)
    REFERENCES `discoursedb_v02`.`group` (`id_group`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Audience_has_Group_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Audience_has_Group_Group1_idx` ON `discoursedb_v02`.`audience_has_group` (`fk_group` ASC);

CREATE INDEX `fk_Audience_has_Group_Audience1_idx` ON `discoursedb_v02`.`audience_has_group` (`fk_audience` ASC);

CREATE INDEX `fk_Audience_has_Group_Annotation1_idx` ON `discoursedb_v02`.`audience_has_group` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`contribution_has_audience`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`contribution_has_audience` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`contribution_has_audience` (
  `fk_contribution` BIGINT UNSIGNED NOT NULL,
  `fk_audience` BIGINT UNSIGNED NOT NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  PRIMARY KEY (`fk_contribution`, `fk_audience`),
  CONSTRAINT `fk_Contribution_has_Audience_Contribution1`
    FOREIGN KEY (`fk_contribution`)
    REFERENCES `discoursedb_v02`.`contribution` (`id_contribution`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contribution_has_Audience_Audience1`
    FOREIGN KEY (`fk_audience`)
    REFERENCES `discoursedb_v02`.`audience` (`id_audience`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contribution_has_Audience_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Contribution_has_Audience_Audience1_idx` ON `discoursedb_v02`.`contribution_has_audience` (`fk_audience` ASC);

CREATE INDEX `fk_Contribution_has_Audience_Contribution1_idx` ON `discoursedb_v02`.`contribution_has_audience` (`fk_contribution` ASC);

CREATE INDEX `fk_Contribution_has_Audience_Annotation1_idx` ON `discoursedb_v02`.`contribution_has_audience` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`context_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`context_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`context_type` (
  `id_context_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(200) NULL,
  PRIMARY KEY (`id_context_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`context`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`context` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`context` (
  `id_context` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_content_first_revision` BIGINT UNSIGNED NULL,
  `fk_content_current_revision` BIGINT UNSIGNED NULL,
  `fk_context_type` BIGINT UNSIGNED NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id_context`),
  CONSTRAINT `fk_Context_Content1`
    FOREIGN KEY (`fk_content_first_revision`)
    REFERENCES `discoursedb_v02`.`content` (`id_content`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Context_Content2`
    FOREIGN KEY (`fk_content_current_revision`)
    REFERENCES `discoursedb_v02`.`content` (`id_content`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Context_Context_Type1`
    FOREIGN KEY (`fk_context_type`)
    REFERENCES `discoursedb_v02`.`context_type` (`id_context_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Context_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Context_Content1_idx` ON `discoursedb_v02`.`context` (`fk_content_first_revision` ASC);

CREATE INDEX `fk_Context_Content2_idx` ON `discoursedb_v02`.`context` (`fk_content_current_revision` ASC);

CREATE INDEX `fk_Context_Context_Type1_idx` ON `discoursedb_v02`.`context` (`fk_context_type` ASC);

CREATE INDEX `fk_Context_Annotation1_idx` ON `discoursedb_v02`.`context` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`contribution_has_context`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`contribution_has_context` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`contribution_has_context` (
  `id_contribution_has_context` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_context` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id_contribution_has_context`, `fk_context`),
  CONSTRAINT `fk_Contribution_has_Context_Contribution1`
    FOREIGN KEY (`id_contribution_has_context`)
    REFERENCES `discoursedb_v02`.`contribution` (`id_contribution`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contribution_has_Context_Context1`
    FOREIGN KEY (`fk_context`)
    REFERENCES `discoursedb_v02`.`context` (`id_context`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contribution_has_Context_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Contribution_has_Context_Context1_idx` ON `discoursedb_v02`.`contribution_has_context` (`fk_context` ASC);

CREATE INDEX `fk_Contribution_has_Context_Contribution1_idx` ON `discoursedb_v02`.`contribution_has_context` (`id_contribution_has_context` ASC);

CREATE INDEX `fk_Contribution_has_Context_Annotation1_idx` ON `discoursedb_v02`.`contribution_has_context` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`content_interaction_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`content_interaction_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`content_interaction_type` (
  `id_content_interaction_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`id_content_interaction_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`content_interaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`content_interaction` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`content_interaction` (
  `fk_user` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_content` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_content_interaction_type` BIGINT UNSIGNED NOT NULL,
  `fk_annotation` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`fk_user`, `fk_content`),
  CONSTRAINT `fk_User_has_Content_User1`
    FOREIGN KEY (`fk_user`)
    REFERENCES `discoursedb_v02`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Content_Content1`
    FOREIGN KEY (`fk_content`)
    REFERENCES `discoursedb_v02`.`content` (`id_content`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Content_Interaction_Content_Interaction_Type1`
    FOREIGN KEY (`fk_content_interaction_type`)
    REFERENCES `discoursedb_v02`.`content_interaction_type` (`id_content_interaction_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Content_Interaction_Annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_User_has_Content_Content1_idx` ON `discoursedb_v02`.`content_interaction` (`fk_content` ASC);

CREATE INDEX `fk_User_has_Content_User1_idx` ON `discoursedb_v02`.`content_interaction` (`fk_user` ASC);

CREATE INDEX `fk_Content_Interaction_Content_Interaction_Type1_idx` ON `discoursedb_v02`.`content_interaction` (`fk_content_interaction_type` ASC);

CREATE INDEX `fk_Content_Interaction_Annotation1_idx` ON `discoursedb_v02`.`content_interaction` (`fk_annotation` ASC);


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`user_relation_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`user_relation_type` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`user_relation_type` (
  `id_user_relation_type` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(200) NULL,
  PRIMARY KEY (`id_user_relation_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `discoursedb_v02`.`user_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discoursedb_v02`.`user_relation` ;

CREATE TABLE IF NOT EXISTS `discoursedb_v02`.`user_relation` (
  `id_user_relation` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_user_source` BIGINT UNSIGNED NOT NULL,
  `fk_user_target` BIGINT UNSIGNED NOT NULL,
  `fk_user_relation_type` BIGINT UNSIGNED NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `fk_annotation` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id_user_relation`),
  CONSTRAINT `fk_User_relatedto_User_User1`
    FOREIGN KEY (`fk_user_source`)
    REFERENCES `discoursedb_v02`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_relatedto_User_User2`
    FOREIGN KEY (`fk_user_target`)
    REFERENCES `discoursedb_v02`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_relation_user_relation_type1`
    FOREIGN KEY (`fk_user_relation_type`)
    REFERENCES `discoursedb_v02`.`user_relation_type` (`id_user_relation_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_relation_annotation1`
    FOREIGN KEY (`fk_annotation`)
    REFERENCES `discoursedb_v02`.`annotation` (`id_annotation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_User_relatedto_User_User1_idx` ON `discoursedb_v02`.`user_relation` (`fk_user_source` ASC);

CREATE INDEX `fk_User_relatedto_User_User2_idx` ON `discoursedb_v02`.`user_relation` (`fk_user_target` ASC);

CREATE INDEX `fk_user_relation_user_relation_type1_idx` ON `discoursedb_v02`.`user_relation` (`fk_user_relation_type` ASC);

CREATE INDEX `fk_user_relation_annotation1_idx` ON `discoursedb_v02`.`user_relation` (`fk_annotation` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `discoursedb_v02`.`discoursedb`
-- -----------------------------------------------------
START TRANSACTION;
USE `discoursedb_v02`;
INSERT INTO `discoursedb_v02`.`discoursedb` (`id_discoursedb`, `schema_version`, `start_time`, `end_time`) VALUES (DEFAULT, '0.2', 'NOW()', NULL);

COMMIT;

