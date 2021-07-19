-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 17-Jul-2021 às 21:43
-- Versão do servidor: 10.4.18-MariaDB
-- versão do PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `app_controll`
--
CREATE DATABASE IF NOT EXISTS `app_controll` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `app_controll`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `address`
--

CREATE TABLE IF NOT EXISTS `address` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED DEFAULT NULL,
  `street` varchar(255) NOT NULL DEFAULT '',
  `number` varchar(255) NOT NULL DEFAULT '',
  `complement` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `addr_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `address`
--

INSERT INTO `address` VALUES(1, 1, 'rua 9', '01', 'casa 1', '2021-07-15 19:40:57', '2021-07-17 17:14:24');

-- --------------------------------------------------------

--
-- Estrutura da tabela `app_categories`
--

CREATE TABLE IF NOT EXISTS `app_categories` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sub_of` int(11) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(15) NOT NULL DEFAULT '',
  `order_by` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `sub_of` (`sub_of`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `app_categories`
--

INSERT INTO `app_categories` VALUES(1, NULL, 'Salário', 'income', 0, '2018-11-29 10:30:32', '2018-11-29 11:10:21');
INSERT INTO `app_categories` VALUES(2, NULL, 'Investimento', 'income', 1, '2018-11-29 10:30:41', '2018-12-04 23:03:30');
INSERT INTO `app_categories` VALUES(3, NULL, 'Empréstimo', 'income', 1, '2018-11-29 10:30:53', '2018-12-04 23:03:35');
INSERT INTO `app_categories` VALUES(4, NULL, 'Outras receitas', 'income', 2, '2018-11-29 10:31:21', '2018-11-29 11:09:59');
INSERT INTO `app_categories` VALUES(5, NULL, 'Alimentação', 'expense', 0, '2018-11-29 10:32:15', '2018-11-29 10:32:15');
INSERT INTO `app_categories` VALUES(6, NULL, 'Aluguel', 'expense', 0, '2018-11-29 10:32:19', '2018-12-04 23:03:44');
INSERT INTO `app_categories` VALUES(7, NULL, 'Compras', 'expense', 0, '2018-11-29 10:32:33', '2018-11-29 10:32:33');
INSERT INTO `app_categories` VALUES(8, NULL, 'Educação', 'expense', 0, '2018-11-29 10:32:34', '2018-11-29 10:32:38');
INSERT INTO `app_categories` VALUES(9, NULL, 'Entretenimento', 'expense', 0, '2018-11-29 10:32:49', '2018-11-29 10:32:51');
INSERT INTO `app_categories` VALUES(10, NULL, 'Impostos e taxas', 'expense', 0, '2018-11-29 10:32:57', '2018-11-29 10:32:57');
INSERT INTO `app_categories` VALUES(11, NULL, 'Saúde', 'expense', 0, '2018-11-29 10:33:08', '2018-11-29 10:33:31');
INSERT INTO `app_categories` VALUES(12, NULL, 'Serviços', 'expense', 0, '2018-11-29 10:33:13', '2018-11-29 10:33:32');
INSERT INTO `app_categories` VALUES(13, NULL, 'Viagen', 'expense', 0, '2018-11-29 10:33:23', '2018-12-04 23:03:56');
INSERT INTO `app_categories` VALUES(14, NULL, 'Outras despesas', 'expense', 2, '2018-11-29 10:33:29', '2018-11-29 11:10:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `app_credit_cards`
--

CREATE TABLE IF NOT EXISTS `app_credit_cards` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `brand` varchar(20) NOT NULL DEFAULT '',
  `last_digits` varchar(11) NOT NULL DEFAULT '',
  `cvv` varchar(11) NOT NULL DEFAULT '',
  `hash` varchar(255) NOT NULL DEFAULT '',
  `status` varchar(255) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `credit_cards_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `app_credit_cards`
--

INSERT INTO `app_credit_cards` VALUES(1, 1, 'visa', '5386', '978', 'card_cjqh0engf02q34ka6ewd27xk8ya', 'active', '2021-07-17 19:22:37', '2021-07-17 19:23:30');

-- --------------------------------------------------------

--
-- Estrutura da tabela `app_invoices`
--

CREATE TABLE IF NOT EXISTS `app_invoices` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `wallet_id` int(11) UNSIGNED NOT NULL,
  `category_id` int(11) UNSIGNED NOT NULL,
  `invoice_of` int(11) UNSIGNED DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(15) NOT NULL DEFAULT '',
  `value` decimal(10,2) NOT NULL,
  `currency` varchar(5) NOT NULL DEFAULT 'BRL',
  `due_at` date NOT NULL,
  `repeat_when` varchar(10) NOT NULL DEFAULT '',
  `period` varchar(10) NOT NULL DEFAULT 'month',
  `enrollments` int(11) DEFAULT NULL,
  `enrollment_of` int(11) DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'unpaid',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `app_user` (`user_id`),
  KEY `app_wallet` (`wallet_id`),
  KEY `app_category` (`category_id`),
  KEY `app_invoice` (`invoice_of`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `app_invoices`
--

INSERT INTO `app_invoices` VALUES(1, 1, 24, 4, NULL, 'Aluguel', 'fixed_income', '600.00', 'BRL', '2021-08-10', 'fixed', 'month', 1, 1, 'paid', '2021-07-17 17:24:52', '2021-07-17 17:24:52');
INSERT INTO `app_invoices` VALUES(2, 1, 24, 4, 1, 'Aluguel', 'income', '600.00', 'BRL', '2021-08-10', 'fixed', 'month', 1, 1, 'unpaid', '2021-07-17 17:24:53', '2021-07-17 17:24:53');
INSERT INTO `app_invoices` VALUES(3, 1, 24, 4, 1, 'Aluguel', 'income', '600.00', 'BRL', '2021-09-10', 'fixed', 'month', 1, 1, 'unpaid', '2021-07-17 17:24:53', '2021-07-17 17:24:53');
INSERT INTO `app_invoices` VALUES(4, 1, 24, 4, 1, 'Aluguel', 'income', '600.00', 'BRL', '2021-10-10', 'fixed', 'month', 1, 1, 'unpaid', '2021-07-17 17:24:53', '2021-07-17 17:24:53');
INSERT INTO `app_invoices` VALUES(5, 1, 24, 2, NULL, 'Carro', 'fixed_income', '500.00', 'BRL', '2021-07-16', 'fixed', 'month', 1, 1, 'paid', '2021-07-17 17:25:39', '2021-07-17 17:25:39');
INSERT INTO `app_invoices` VALUES(6, 1, 24, 2, 5, 'Carro', 'income', '500.00', 'BRL', '2021-07-16', 'fixed', 'month', 1, 1, 'paid', '2021-07-17 17:25:39', '2021-07-17 17:25:39');
INSERT INTO `app_invoices` VALUES(7, 1, 24, 2, 5, 'Carro', 'income', '500.00', 'BRL', '2021-08-16', 'fixed', 'month', 1, 1, 'unpaid', '2021-07-17 17:25:39', '2021-07-17 17:25:39');
INSERT INTO `app_invoices` VALUES(8, 1, 24, 2, 5, 'Carro', 'income', '500.00', 'BRL', '2021-09-16', 'fixed', 'month', 1, 1, 'unpaid', '2021-07-17 17:25:39', '2021-07-17 17:25:39');
INSERT INTO `app_invoices` VALUES(9, 1, 24, 2, 5, 'Carro', 'income', '500.00', 'BRL', '2021-10-16', 'fixed', 'month', 1, 1, 'unpaid', '2021-07-17 17:25:39', '2021-07-17 17:25:39');
INSERT INTO `app_invoices` VALUES(10, 1, 24, 12, NULL, 'internet', 'fixed_expense', '100.00', 'BRL', '2021-07-18', 'fixed', 'month', 1, 1, 'paid', '2021-07-17 17:27:05', '2021-07-17 17:27:05');
INSERT INTO `app_invoices` VALUES(11, 1, 24, 12, 10, 'internet', 'expense', '100.00', 'BRL', '2021-07-18', 'fixed', 'month', 1, 1, 'unpaid', '2021-07-17 17:27:06', '2021-07-17 17:27:06');
INSERT INTO `app_invoices` VALUES(12, 1, 24, 12, 10, 'internet', 'expense', '100.00', 'BRL', '2021-08-18', 'fixed', 'month', 1, 1, 'unpaid', '2021-07-17 17:27:06', '2021-07-17 17:27:06');
INSERT INTO `app_invoices` VALUES(13, 1, 24, 12, 10, 'internet', 'expense', '100.00', 'BRL', '2021-09-18', 'fixed', 'month', 1, 1, 'unpaid', '2021-07-17 17:27:06', '2021-07-17 17:27:06');

-- --------------------------------------------------------

--
-- Estrutura da tabela `app_orders`
--

CREATE TABLE IF NOT EXISTS `app_orders` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED DEFAULT NULL,
  `card_id` int(11) UNSIGNED DEFAULT NULL,
  `subscription_id` int(11) UNSIGNED DEFAULT NULL,
  `transaction` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT '',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `orders_user` (`user_id`),
  KEY `orders_credit_card` (`card_id`),
  KEY `orders_subscription` (`subscription_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `app_plans`
--

CREATE TABLE IF NOT EXISTS `app_plans` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `period` varchar(11) NOT NULL DEFAULT '',
  `period_str` varchar(11) NOT NULL DEFAULT '',
  `price` decimal(10,2) NOT NULL,
  `status` varchar(11) NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `app_plans`
--

INSERT INTO `app_plans` VALUES(1, 'PRO', '1year', 'ano', '50.00', 'active', '2021-07-16 19:33:40', '2021-07-17 19:34:47');

-- --------------------------------------------------------

--
-- Estrutura da tabela `app_subscriptions`
--

CREATE TABLE IF NOT EXISTS `app_subscriptions` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED DEFAULT NULL,
  `plan_id` int(11) UNSIGNED DEFAULT NULL,
  `card_id` int(11) UNSIGNED DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'active' COMMENT 'active,inactive,past_due,canceled',
  `pay_status` varchar(10) NOT NULL DEFAULT 'active' COMMENT 'active,inactive,past_due,canceled',
  `started` date NOT NULL,
  `due_day` int(2) NOT NULL,
  `next_due` date NOT NULL,
  `last_charge` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `subscription_user` (`user_id`),
  KEY `subscription_card` (`card_id`),
  KEY `subscription_plan` (`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `app_subscriptions`
--

INSERT INTO `app_subscriptions` VALUES(1, 1, 1, 1, 'active', 'active', '2021-07-17', 0, '2020-07-17', '2020-07-17', '2021-07-17 19:29:24', '2021-07-17 19:35:04');

-- --------------------------------------------------------

--
-- Estrutura da tabela `app_wallets`
--

CREATE TABLE IF NOT EXISTS `app_wallets` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `wallet` varchar(255) NOT NULL DEFAULT '',
  `free` int(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `wallet_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `app_wallets`
--

INSERT INTO `app_wallets` VALUES(24, 1, 'Minha Carteira', 1, '2021-07-16 19:17:37', '2021-07-16 19:17:37');
INSERT INTO `app_wallets` VALUES(25, 1, 'Empresa', 0, '2021-07-16 21:21:40', '2021-07-16 21:21:40');

-- --------------------------------------------------------

--
-- Estrutura da tabela `mail_queue`
--

CREATE TABLE IF NOT EXISTS `mail_queue` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `from_email` varchar(255) NOT NULL DEFAULT '',
  `from_name` varchar(255) NOT NULL DEFAULT '',
  `recipient_email` varchar(255) NOT NULL DEFAULT '',
  `recipient_name` varchar(255) NOT NULL DEFAULT '',
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `notifications`
--

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `report_access`
--

CREATE TABLE IF NOT EXISTS `report_access` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `users` int(11) NOT NULL DEFAULT 1,
  `views` int(11) NOT NULL DEFAULT 1,
  `pages` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `report_access`
--

INSERT INTO `report_access` VALUES(3, 1, 1, 157, '2021-07-16 18:45:17', '2021-07-16 23:56:00');
INSERT INTO `report_access` VALUES(4, 3, 4, 382, '2021-07-17 11:12:57', '2021-07-17 17:29:10');

-- --------------------------------------------------------

--
-- Estrutura da tabela `report_online`
--

CREATE TABLE IF NOT EXISTS `report_online` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user` int(11) UNSIGNED DEFAULT NULL,
  `ip` varchar(50) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `agent` varchar(255) NOT NULL DEFAULT '',
  `pages` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `report_online`
--

INSERT INTO `report_online` VALUES(12, 1, '::1', '/ops/404', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36', 39, '2021-07-17 17:23:52', '2021-07-17 17:29:10');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL DEFAULT '',
  `last_name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `level` int(11) NOT NULL DEFAULT 1,
  `forget` varchar(255) DEFAULT NULL,
  `genre` varchar(10) DEFAULT NULL,
  `datebirth` date DEFAULT NULL,
  `document` varchar(11) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'registered' COMMENT 'registered, confirmed',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` VALUES(1, 'Railan', 'Bernardo', 'suporte@gmail.com.br', '$2y$10$7aQNdKPaeaX0wwxShqfDN.Jwc4SzPPQGOk7fZdLgV/WmGvVx6oFwm', 1, NULL, 'male', '1995-07-08', '00000000000', 'images/2021/07/railan-bernardo-1626470208.jpg', 'confirmed', '2021-07-15 19:39:07', '2021-07-17 17:28:11');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `users`
--
ALTER TABLE `users` ADD FULLTEXT KEY `full_text` (`first_name`,`last_name`,`email`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `app_categories`
--
ALTER TABLE `app_categories`
  ADD CONSTRAINT `sub_of` FOREIGN KEY (`sub_of`) REFERENCES `app_categories` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `app_credit_cards`
--
ALTER TABLE `app_credit_cards`
  ADD CONSTRAINT `credit_cards_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `app_invoices`
--
ALTER TABLE `app_invoices`
  ADD CONSTRAINT `app_category` FOREIGN KEY (`category_id`) REFERENCES `app_categories` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `app_invoice` FOREIGN KEY (`invoice_of`) REFERENCES `app_invoices` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `app_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `app_wallet` FOREIGN KEY (`wallet_id`) REFERENCES `app_wallets` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `app_orders`
--
ALTER TABLE `app_orders`
  ADD CONSTRAINT `orders_credit_card` FOREIGN KEY (`card_id`) REFERENCES `app_credit_cards` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `orders_subscription` FOREIGN KEY (`subscription_id`) REFERENCES `app_subscriptions` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `app_subscriptions`
--
ALTER TABLE `app_subscriptions`
  ADD CONSTRAINT `subscription_card` FOREIGN KEY (`card_id`) REFERENCES `app_credit_cards` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `subscription_plan` FOREIGN KEY (`plan_id`) REFERENCES `app_plans` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `subscription_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `app_wallets`
--
ALTER TABLE `app_wallets`
  ADD CONSTRAINT `wallet_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;


--
-- Metadata
--
USE `phpmyadmin`;

--
-- Metadata para tabela address
--

--
-- Metadata para tabela app_categories
--

--
-- Metadata para tabela app_credit_cards
--

--
-- Metadata para tabela app_invoices
--

--
-- Metadata para tabela app_orders
--

--
-- Metadata para tabela app_plans
--

--
-- Metadata para tabela app_subscriptions
--

--
-- Metadata para tabela app_wallets
--

--
-- Metadata para tabela mail_queue
--

--
-- Metadata para tabela notifications
--

--
-- Metadata para tabela report_access
--

--
-- Metadata para tabela report_online
--

--
-- Metadata para tabela users
--

--
-- Metadata para o banco de dados app_controll
--
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
