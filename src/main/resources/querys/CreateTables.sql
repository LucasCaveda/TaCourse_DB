-- MySQL Script generated by MySQL Workbench
-- Mon May 16 01:10:20 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`country` (
  `idCountry` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCountry`));

-- -----------------------------------------------------
-- Table `mydb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`city` (
  `id_city` INT NOT NULL auto_increment,
  `name` VARCHAR(45),
  `Country_id` INT NOT NULL,
  PRIMARY KEY (`id_city`, `Country_id`),
  INDEX `fk_city_Country1_idx` (`Country_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `mydb`.`country` (`idCountry`));


-- -----------------------------------------------------
-- Table `mydb`.`president`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`president` (
  `id_president` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_president`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`stadium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stadium` (
  `id` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`, `city_id`),
  INDEX `fk_stadium_city1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_stadium_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`city` (`id_city`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`tecnichal_manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`technical_manager` (
  `id_technical_manager` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `birthday` DATE NOT NULL,
  PRIMARY KEY (`id_technical_manager`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`football_team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`football_team` (
  `id` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NOT NULL,
  `technical_manager_id` INT NOT NULL,
  `stadium_id` INT NOT NULL,
  `president_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`, `technical_manager_id`, `stadium_id`, `president_id`, `city_id`),
  INDEX `fk_football_team_technical_manager1_idx` (`technical_manager_id` ASC) VISIBLE,
  INDEX `fk_football_team_stadium1_idx` (`stadium_id` ASC) VISIBLE,
  INDEX `fk_football_team_president1_idx` (`president_id` ASC) VISIBLE,
  INDEX `fk_football_team_city1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_football_team_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`city` (`id_city`),
  CONSTRAINT `fk_football_team_president1`
    FOREIGN KEY (`president_id`)
    REFERENCES `mydb`.`president` (`id_president`),
  CONSTRAINT `fk_football_team_stadium1`
    FOREIGN KEY (`stadium_id`)
    REFERENCES `mydb`.`stadium` (`id`),
  CONSTRAINT `fk_football_team_technical_manager1`
    FOREIGN KEY (`technical_manager_id`)
    REFERENCES `mydb`.`technical_manager` (`id_technical_manager`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`captain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`captain` (
  `id_captain` INT NOT NULL auto_increment,
  `football_team_id` INT NOT NULL,
  PRIMARY KEY (`id_captain`, `football_team_id`),
  INDEX `fk_captain_football_team1_idx` (`football_team_id` ASC) VISIBLE,
  CONSTRAINT `fk_captain_football_team1`
    FOREIGN KEY (`football_team_id`)
    REFERENCES `mydb`.`football_team` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`football_league`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`football_league` (
  `id` INT NOT NULL auto_increment,
  `name` VARCHAR(16) NOT NULL,
  `category` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

drop table `match`;

-- -----------------------------------------------------
-- Table `mydb`.`championship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`championship` (
  `id` INT NOT NULL auto_increment,
  `name` VARCHAR(16) NOT NULL,
  `football_league_id` INT NOT NULL,
  PRIMARY KEY (`id`, `football_league_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_championship_football_league1_idx` (`football_league_id` ASC) VISIBLE,
  CONSTRAINT `fk_championship_football_league1`
    FOREIGN KEY (`football_league_id`)
    REFERENCES `mydb`.`football_league` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `mydb`.`matchs`
-- -----------------------------------------------------

CREATE TABLE IF NOT exists `mydb`.`match` (
  `id` INT NOT NULL auto_increment,
  `q_goals` INT NULL DEFAULT NULL,
  `result` INT NOT NULL,
  `date` DATE NOT NULL,
  `championship_id` INT NOT NULL,
  `stadium_id` INT NOT NULL,
  `football_team1_id` INT NOT NULL,
  `football_team2_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`championship_id`)
  REFERENCES `championship` (`id`),
  FOREIGN KEY (`football_team1_id`)
  REFERENCES `football_team` (`id`),
  FOREIGN KEY (`football_team2_id`)
  REFERENCES `football_team` (`id`),
  FOREIGN KEY (`stadium_id`)
  REFERENCES `mydb`.`stadium` (`id`));
    
CREATE TABLE IF NOT EXISTS `mydb`.`match` (
  `id` INT NOT NULL auto_increment,
  `q_goals` INT NULL DEFAULT NULL,
  `result` INT NOT NULL,
  `date` DATE NOT NULL,
  `championship_id` INT NOT NULL,
  `stadium_id` INT NOT NULL,
  `football_team_id` INT NOT NULL,
  `football_team_technical_manager_id` INT NOT NULL,
  PRIMARY KEY (`id`, `championship_id`, `stadium_id`, `football_team_id`,`football_team_technical_manager_id`),
  INDEX `fk_match_championship1_idx` (`championship_id` ASC) VISIBLE,
  INDEX `fk_match_stadium1_idx` (`stadium_id` ASC) VISIBLE,
  INDEX `fk_match_football_team1_idx` (`football_team_id` ASC, `football_team_technical_manager_id` ASC) VISIBLE,
  INDEX `fk_match_football_team2_idx` (`football_team_id` ASC, `football_team_technical_manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_match_championship1`
    FOREIGN KEY (`championship_id`)
    REFERENCES `mydb`.`championship` (`id`),
  CONSTRAINT `fk_match_football_team1`
    FOREIGN KEY (`football_team_id` , `football_team_technical_manager_id`)
    REFERENCES `mydb`.`football_team` (`id` , `technical_manager_id`),
  CONSTRAINT `fk_match_stadium1`
    FOREIGN KEY (`stadium_id`)
    REFERENCES `mydb`.`stadium` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ticket` (
  `idTicket` INT NOT NULL auto_increment,
  `date` DATE NULL DEFAULT NULL,
  `ubication` INT NULL DEFAULT NULL,
  `stadium_id` INT NOT NULL,
  PRIMARY KEY (`idTicket`, `stadium_id`),
  INDEX `fk_Ticket_stadium1_idx` (`stadium_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ticket_stadium1`
    FOREIGN KEY (`stadium_id`)
    REFERENCES `mydb`.`stadium` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`fans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fan` (
  `id_fan` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NULL DEFAULT NULL,
  `Ticket_id` INT NOT NULL,
  `match_id` INT NOT NULL,
  PRIMARY KEY (`id_fan`, `Ticket_id`, `match_id`),
  INDEX `fk_fans_Ticket1_idx` (`Ticket_id` ASC) VISIBLE,
  INDEX `fk_fans_match1_idx` (`match_id` ASC) VISIBLE,
  CONSTRAINT `fk_fans_match1`
    FOREIGN KEY (`match_id`)
    REFERENCES `mydb`.`match` (`id`),
  CONSTRAINT `fk_fans_Ticket1`
    FOREIGN KEY (`Ticket_id`)
    REFERENCES `mydb`.`ticket` (`idTicket`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`owner` (
  `id_owner` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NULL DEFAULT NULL,
  `football_team_id` INT NOT NULL,
  PRIMARY KEY (`id_owner`, `football_team_id`),
  INDEX `fk_owner_football_team1_idx` (`football_team_id` ASC) VISIBLE,
  CONSTRAINT `fk_owner_football_team1`
    FOREIGN KEY (`football_team_id`)
    REFERENCES `mydb`.`football_team` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`partners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`partners` (
  `idPartners` INT NOT NULL auto_increment,
  `brand_name` VARCHAR(45) NULL DEFAULT NULL,
  `football_team_id` INT NOT NULL,
  PRIMARY KEY (`idPartners`, `football_team_id`),
  INDEX `fk_Partners_football_team1_idx` (`football_team_id` ASC) VISIBLE,
  CONSTRAINT `fk_Partners_football_team1`
    FOREIGN KEY (`football_team_id`)
    REFERENCES `mydb`.`football_team` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`player` (
  `id_player` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NULL DEFAULT NULL,
  `birthday` DATE NULL DEFAULT NULL,
  `shirt_number` INT NULL DEFAULT NULL,
  `banns` INT NULL DEFAULT NULL,
  `goals` INT NULL DEFAULT NULL,
  `football_team_id` INT NOT NULL,
  PRIMARY KEY (`id_player`, `football_team_id`),
  INDEX `fk_player_football_team1_idx` (`football_team_id` ASC) VISIBLE,
  CONSTRAINT `fk_player_football_team1`
    FOREIGN KEY (`football_team_id`)
    REFERENCES `mydb`.`football_team` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`referee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`referee` (
  `id_referee` INT NOT NULL auto_increment,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NULL DEFAULT NULL,
  `birthday` DATE NULL DEFAULT NULL,
  `match_id` INT NOT NULL,
  PRIMARY KEY (`id_referee`, `match_id`),
  INDEX `fk_referee_match1_idx` (`match_id` ASC) VISIBLE,
  CONSTRAINT `fk_referee_match1`
    FOREIGN KEY (`match_id`)
    REFERENCES `mydb`.`match` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;