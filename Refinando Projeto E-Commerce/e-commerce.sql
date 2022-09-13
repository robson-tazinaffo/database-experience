-- MySQL Script generated by MySQL Workbench
-- Tue Sep 13 01:31:03 2022
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
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Produto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Categoria` INT NULL,
  `Descricao` VARCHAR(45) NULL,
  `Valor` FLOAT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`endereco_entrega`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`endereco_entrega` ;

CREATE TABLE IF NOT EXISTS `mydb`.`endereco_entrega` (
  `idendereco_entrega` INT NOT NULL,
  `endereco` VARCHAR(45) NULL,
  `cidade` VARCHAR(45) NULL,
  `estado` CHAR(2) NULL,
  `cep` VARCHAR(10) NULL,
  PRIMARY KEY (`idendereco_entrega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Identificacao` VARCHAR(8) NULL DEFAULT 'Juridica',
  `Endereco` VARCHAR(45) NULL,
  `Cpf_cnpj` VARCHAR(14) NULL,
  `endereco_entrega_idendereco_entrega` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Cpf_cnpj_UNIQUE` (`Cpf_cnpj` ASC) VISIBLE,
  INDEX `fk_Cliente_endereco_entrega1_idx` (`endereco_entrega_idendereco_entrega` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_endereco_entrega1`
    FOREIGN KEY (`endereco_entrega_idendereco_entrega`)
    REFERENCES `mydb`.`endereco_entrega` (`idendereco_entrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`tipo_pedido` ;

CREATE TABLE IF NOT EXISTS `mydb`.`tipo_pedido` (
  `idtipo_pedido` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `ativo` INT NULL,
  PRIMARY KEY (`idtipo_pedido`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrega`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Entrega` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Entrega` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT NULL,
  `Previsao` DATE NULL,
  `Status` CHAR(1) NULL,
  `Data_status` TIMESTAMP NULL,
  `Cod_rastreio` VARCHAR(45) NULL,
  PRIMARY KEY (`idEntrega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`tipo_pagamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`tipo_pagamento` (
  `idtipo_pagamento` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `parcelas` INT NULL,
  `valor_parcela` FLOAT NULL DEFAULT 0,
  `entrada` FLOAT NULL DEFAULT 0,
  PRIMARY KEY (`idtipo_pagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pedido` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Status` CHAR(1) NULL,
  `Descricao` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `tipo_pedido_idtipo_pedido` INT NOT NULL,
  `Frete` FLOAT NULL,
  `Entrega_idEntrega` INT NOT NULL,
  `tipo_pagamento_idtipo_pagamento` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`, `tipo_pagamento_idtipo_pagamento`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Pedido_tipo_pedido1_idx` (`tipo_pedido_idtipo_pedido` ASC) VISIBLE,
  INDEX `fk_Pedido_Entrega1_idx` (`Entrega_idEntrega` ASC) VISIBLE,
  INDEX `fk_Pedido_tipo_pagamento1_idx` (`tipo_pagamento_idtipo_pagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_tipo_pedido1`
    FOREIGN KEY (`tipo_pedido_idtipo_pedido`)
    REFERENCES `mydb`.`tipo_pedido` (`idtipo_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Entrega1`
    FOREIGN KEY (`Entrega_idEntrega`)
    REFERENCES `mydb`.`Entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_tipo_pagamento1`
    FOREIGN KEY (`tipo_pagamento_idtipo_pagamento`)
    REFERENCES `mydb`.`tipo_pagamento` (`idtipo_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`fornecedor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`fornecedor` (
  `idfornecedor` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(20) NULL,
  PRIMARY KEY (`idfornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Produto_fornecedor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Produto_fornecedor` (
  `fornecedor_idfornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`fornecedor_idfornecedor`, `Produto_idProduto`),
  INDEX `fk_fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_fornecedor_has_Produto_fornecedor_idx` (`fornecedor_idfornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_fornecedor_has_Produto_fornecedor`
    FOREIGN KEY (`fornecedor_idfornecedor`)
    REFERENCES `mydb`.`fornecedor` (`idfornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Estoque` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_Estoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Produto_Estoque` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Produto_Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `mydb`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Produto_Pedido` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Produto_Pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`forma_pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`forma_pagamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`forma_pagamento` (
  `idforma_pagamento` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `tipo_pagamento_idtipo_pagamento` INT NOT NULL,
  PRIMARY KEY (`idforma_pagamento`, `tipo_pagamento_idtipo_pagamento`),
  INDEX `fk_forma_pagamento_tipo_pagamento1_idx` (`tipo_pagamento_idtipo_pagamento` ASC) VISIBLE,
  CONSTRAINT `fk_forma_pagamento_tipo_pagamento1`
    FOREIGN KEY (`tipo_pagamento_idtipo_pagamento`)
    REFERENCES `mydb`.`tipo_pagamento` (`idtipo_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
