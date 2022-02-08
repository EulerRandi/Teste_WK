CREATE DATABASE /*!32312 IF NOT EXISTS*/`testewb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `testewb`;

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cidade` varchar(60) NOT NULL,
  `uf` varchar(2) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

insert  into `clientes`(`codigo`,`nome`,`cidade`,`uf`) values 
(1,'Antonio Donizete Bobo','São Paulo','SP'),
(2,'Benedito Camurça Aveludado','Rio de Janeiro','RJ'),
(3,'Caius Marcius Africanus','Salvador','BA'),
(4,'Safira Azul Esverdeada','Brasília','DF'),
(5,'Edna Boa Sorte','Fortaleza','CE'),
(6,'Felicidade do Lar Brasileiro','Belo Horizonte','MG'),
(7,'Gol Santana Silva','Manaus','AM'),
(8,'Himineu Casamenticio das Dores Conjugais','Curitiba','PR'),
(9,'sabel Defensora de Jesus','Recife','PE'),
(10,'Jacinto Leite Aquino Rêgo','Porto Alegre','RS'),
(11,'João Meias de Golveias','Belém','PA'),
(12,'Kussen Pestana','Goiânia','GO'),
(13,'Lindulfo Celidonio Calafange de Tefé','Guarulhos','SP'),
(14,'Luis Grampeado','Campinas','SP'),
(15,'Maria Constança Dores Pança','São Luís','MA'),
(16,'Napoleão Estado do Pernambuco','São Gonçalo','RJ'),
(17,'Olinda Barba de Jesus','Maceió','AL'),
(18,'Paulo Tapioca','Duque de Caxias','RJ'),
(19,'Rita Marciana Arrotéia','	Teresina','PI'),
(20,'Terebentina Terepenis','Natal','RN');

DROP TABLE IF EXISTS `pedidoitens`;

CREATE TABLE `pedidoitens` (
  `item` int(11) NOT NULL AUTO_INCREMENT,
  `pedido` int(11) NOT NULL,
  `produto` int(11) NOT NULL,
  `vr_unit` float NOT NULL,
  `quantidade` float NOT NULL,
  `vr_total` float NOT NULL,
  PRIMARY KEY (`item`),
  KEY `pedido` (`pedido`),
  KEY `produto` (`produto`),
  CONSTRAINT `pedidoitens_ibfk_1` FOREIGN KEY (`pedido`) REFERENCES `pedidos` (`pedido`),
  CONSTRAINT `pedidoitens_ibfk_2` FOREIGN KEY (`produto`) REFERENCES `produtos` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `pedidos`;

CREATE TABLE `pedidos` (
  `pedido` int(11) NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `cliente` int(11) NOT NULL,
  `vr_total` float DEFAULT NULL,
  PRIMARY KEY (`pedido`),
  KEY `ind_cliente` (`cliente`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `produtos`;

CREATE TABLE `produtos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) DEFAULT NULL,
  `preco_venda` double DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

insert  into `produtos`(`codigo`,`descricao`,`preco_venda`) values 
(1,'Roupas',41.09),
(2,'Sapatos',35),
(3,'Celulares',1234.54),
(4,'Notebooks',3456.78),
(5,'Livros',35.99),
(6,'Brinquedos',154.94),
(7,'Produtos para o cabelo',85.73),
(8,'Perfumes',256.86),
(9,'Artigos de armarinhos',25),
(10,'Games',210),
(11,'Maquiagem',85),
(12,'Tapetes',124.34),
(13,'Quadros para decoração',548.76),
(14,'Acessórios',35.86),
(15,'Cursos',35.99),
(16,'Bolsas',99.98),
(17,'Produtos para animais de estimação',85.44),
(18,'Garrafas de água',5),
(19,'Artigos para escritório',15),
(20,'Equipamentos para exercícios físicos',700);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
