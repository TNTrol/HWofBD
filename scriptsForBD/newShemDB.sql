-- MySQL Script generated by MySQL Workbench
-- Пт 11 дек 2020 02:26:32
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`timestamps`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`timestamps` ;

CREATE TABLE IF NOT EXISTS `mydb`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


-- -----------------------------------------------------
-- Table `mydb`.`DISPATCHER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`DISPATCHER` ;

CREATE TABLE IF NOT EXISTS `mydb`.`DISPATCHER` (
  `ID_DISPATCHER` INT NOT NULL AUTO_INCREMENT,
  `SECOND_NAME` VARCHAR(45) NOT NULL,
  `NAME` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_DISPATCHER`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AIRLINE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`AIRLINE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`AIRLINE` (
  `ID_AIRLINE` INT NOT NULL AUTO_INCREMENT,
  `NAME_AIRLINE` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_AIRLINE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AIRCRAFT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`AIRCRAFT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`AIRCRAFT` (
  `ID_AIRCRAFT` INT NOT NULL AUTO_INCREMENT,
  `NAME_AIRCRAFT` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_AIRCRAFT`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LANDING_ACT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LANDING_ACT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LANDING_ACT` (
  `ID_ACT` INT NOT NULL AUTO_INCREMENT,
  `DATE` DATE NOT NULL,
  `ID_DISPATCHER` INT NOT NULL,
  `ID_AIRLINE` INT NOT NULL,
  `TYPE_AIRCRAFT` INT NOT NULL,
  PRIMARY KEY (`ID_ACT`),
  INDEX `Диспетчер_idx` (`ID_DISPATCHER` ASC) ,
  INDEX `Авиакомпания_idx` (`ID_AIRLINE` ASC) ,
  INDEX `Тип самолета_idx` (`TYPE_AIRCRAFT` ASC) ,
  CONSTRAINT `DISPATHER`
    FOREIGN KEY (`ID_DISPATCHER`)
    REFERENCES `mydb`.`DISPATCHER` (`ID_DISPATCHER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AIRLINE`
    FOREIGN KEY (`ID_AIRLINE`)
    REFERENCES `mydb`.`AIRLINE` (`ID_AIRLINE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AIRCRAFT`
    FOREIGN KEY (`TYPE_AIRCRAFT`)
    REFERENCES `mydb`.`AIRCRAFT` (`ID_AIRCRAFT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SCORE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SCORE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SCORE` (
  `ID_SCORE` INT NOT NULL AUTO_INCREMENT,
  `ID_ACT` INT NOT NULL,
  `SCORE` DOUBLE NOT NULL,
  PRIMARY KEY (`ID_SCORE`),
  UNIQUE INDEX `id Акта посадки_UNIQUE` (`ID_ACT` ASC) ,
  CONSTRAINT `ACT`
    FOREIGN KEY (`ID_ACT`)
    REFERENCES `mydb`.`LANDING_ACT` (`ID_ACT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RATE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`RATE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RATE` (
  `DATE` DATE NOT NULL,
  `EURO` DOUBLE NOT NULL,
  PRIMARY KEY (`DATE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TECH_SERVICE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TECH_SERVICE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TECH_SERVICE` (
  `ID_SERVICE` INT NOT NULL AUTO_INCREMENT,
  `NAME_SERVICE` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_SERVICE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EARTH_SERVICE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EARTH_SERVICE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EARTH_SERVICE` (
  `ID_SERVICE` INT NOT NULL AUTO_INCREMENT,
  `NAME_SERVICE` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_SERVICE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TARIFF`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TARIFF` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TARIFF` (
  `ID_TARIFF` INT NOT NULL AUTO_INCREMENT,
  `ID_AIRCRAFT` INT NOT NULL,
  `TYPE_SERVICE` TINYINT NOT NULL,
  `ID_SERVICE` INT NOT NULL,
  `COST` DOUBLE NOT NULL,
  PRIMARY KEY (`ID_TARIFF`),
  INDEX `AIRCRAFT_TARRIFF` (`ID_AIRCRAFT` ASC),
  INDEX `ID_SERVICE_TECH` (`ID_SERVICE` ASC) ,
  CONSTRAINT `AIRCRAFT_TARRIFF`
    FOREIGN KEY (`ID_AIRCRAFT`)
    REFERENCES `mydb`.`AIRCRAFT` (`ID_AIRCRAFT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SERVICE_TECH_TARIFF`
    FOREIGN KEY (`ID_SERVICE`)
    REFERENCES `mydb`.`TECH_SERVICE` (`ID_SERVICE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SERVICE_EARTH_TARIFF`
    FOREIGN KEY (`ID_SERVICE`)
    REFERENCES `mydb`.`EARTH_SERVICE` (`ID_SERVICE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LIST_SERVICE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LIST_SERVICE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LIST_SERVICE` (
  `ID_ACT` INT NOT NULL,
  `TYPE_SERVICE` TINYINT NOT NULL,
  `ID_SERVICE` INT NOT NULL,
  INDEX `Акт посадки_idx` (`ID_ACT` ASC) ,
  INDEX `Раьоты_idx` (`ID_SERVICE` ASC) ,
  CONSTRAINT `ACT_SERVICE`
    FOREIGN KEY (`ID_ACT`)
    REFERENCES `mydb`.`LANDING_ACT` (`ID_ACT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SERVICE_EARTH_LIST_SERVICE`
    FOREIGN KEY (`ID_SERVICE`)
    REFERENCES `mydb`.`EARTH_SERVICE` (`ID_SERVICE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SERVICE_TECH_LIST_SERVICE`
    FOREIGN KEY (`ID_SERVICE`)
    REFERENCES `mydb`.`TECH_SERVICE` (`ID_SERVICE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USERS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`USERS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`USERS` (
  `ID_USER` INT NOT NULL AUTO_INCREMENT,
  `LOGIN` VARCHAR(45) NOT NULL,
  `USER_NAME` VARCHAR(100) NOT NULL,
  `ROLE` INT NOT NULL,
  `ID_PRIVATE` INT NULL,
  `PASSWORD` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_USER`),
  UNIQUE INDEX `ID_USER_UNIQUE` (`ID_USER` ASC) ,
  INDEX `fk_USERS_1_idx` (`ID_PRIVATE` ASC) ,
  UNIQUE INDEX `LOGIN_UNIQUE` (`LOGIN` ASC) ,
  CONSTRAINT `fk_USERS_1`
    FOREIGN KEY (`ID_PRIVATE`)
    REFERENCES `mydb`.`DISPATCHER` (`ID_DISPATCHER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USERS_2`
    FOREIGN KEY (`ID_PRIVATE`)
    REFERENCES `mydb`.`AIRLINE` (`ID_AIRLINE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`LANDING ACT_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`LANDING ACT_BEFORE_INSERT` BEFORE INSERT ON `LANDING_ACT` FOR EACH ROW
BEGIN

IF (NEW.DATE <> CURRENT_DATE() ) THEN
KILL QUERY CONNECTION_ID(); 
END IF;

END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
