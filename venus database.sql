-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th6 20, 2024 lúc 01:35 PM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `venus`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `booking_table`
--

CREATE TABLE `booking_table` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `person_number` int(11) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `special` int(11) DEFAULT NULL,
  `end_time` varchar(255) DEFAULT NULL,
  `start_time` varchar(255) DEFAULT NULL,
  `table_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `booking_table`
--

INSERT INTO `booking_table` (`id`, `created_on`, `updated_on`, `version`, `date`, `email`, `name`, `person_number`, `phone_number`, `status`, `time`, `special`, `end_time`, `start_time`, `table_id`) VALUES
(16, '2024-06-20 10:16:41.000000', NULL, 0, '2024-06-20', 'bellpham97@gmail.com', 'Pham Hung Quoc Vinh', 2, '0909367216', 0, NULL, 0, '15:00', '14:00', 30),
(17, '2024-06-20 10:24:03.000000', NULL, 0, '2024-06-20', 'b@gmail.com', 'Minh Luan', 4, '0123456788', 0, NULL, 0, '16:00', '15:00', 31),
(18, '2024-06-20 13:29:04.000000', NULL, 0, '2024-06-20', 'bellpham97@gmail.com', 'Pham Hung Quoc Vinh', 4, '0909367216', 0, NULL, 0, '18:00', '17:00', 31),
(19, '2024-06-20 13:32:40.000000', NULL, 0, '2024-06-21', 'phuoc@gmail.com', 'Phuoc', 4, '0123333333', 0, NULL, 0, '16:00', '13:00', 31);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart_lines`
--

CREATE TABLE `cart_lines` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `order_time` datetime(6) DEFAULT NULL,
  `price` decimal(38,2) DEFAULT NULL,
  `quantity` decimal(38,2) DEFAULT NULL,
  `status` enum('PENDING','READY','SERVING','COMPLETED','PREPARING') NOT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `ingredient_id` bigint(20) DEFAULT NULL,
  `table_id` bigint(20) DEFAULT NULL,
  `half_portion` bit(1) NOT NULL,
  `order_status` tinyint(1) DEFAULT 0,
  `order_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category_f`
--

CREATE TABLE `category_f` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `category_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `category_f`
--

INSERT INTO `category_f` (`id`, `created_on`, `updated_on`, `version`, `category_name`) VALUES
(1, NULL, NULL, 0, 'Pork'),
(2, NULL, NULL, 0, 'Fish'),
(4, NULL, NULL, 0, 'Beef'),
(5, NULL, NULL, 0, 'Drinks'),
(6, NULL, NULL, 0, 'Seafood'),
(8, NULL, NULL, 0, 'Soups'),
(10, NULL, NULL, 0, 'Vegetables');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category_t`
--

CREATE TABLE `category_t` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `category_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `category_t`
--

INSERT INTO `category_t` (`id`, `created_on`, `updated_on`, `version`, `category_name`) VALUES
(1, NULL, NULL, 0, 'zone1'),
(2, NULL, NULL, 0, 'zone2');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) NOT NULL,
  `admin_response` varchar(1024) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `full_name` varchar(64) DEFAULT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `phone` varchar(1024) DEFAULT NULL,
  `created_time` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `contacts`
--

INSERT INTO `contacts` (`id`, `admin_response`, `email`, `full_name`, `message`, `phone`, `created_time`) VALUES
(1, '', 'bellpham97@gmail.com', 'Tommy Pham', 'Good afternoon, I\'m interested in dining at your establishment but have some dietary restrictions. Do you offer gluten-free options, and can you accommodate a nut allergy?', '09093821922', '2024-04-18 00:31:44.000000'),
(2, NULL, 'bellpham97@gmail.com', 'Pham Hung Quoc Vinh', 'I need your help', '0909367216', '2024-06-03 16:01:10.000000'),
(52, NULL, 'bellpham97@gmail.com', 'vinh', 'very good staff', '0909367216', '2024-06-17 20:50:47.000000'),
(2452, NULL, 'bellpham97@gmail.com', 'Pham Hung Quoc Vinh', 'Hello, Do you have any chairs for children around 1-2 years old? and vegan menu ?\r\nThanks', '0909367216', '2024-05-16 09:31:45.000000'),
(2502, NULL, 'bellpham97@gmail.com', 'Pham Hung Quoc Vinh', 'I need your help', '0909367216', '2024-05-20 16:42:06.000000'),
(2552, NULL, 'bellpham97@gmail.com', 'Pham Hung Quoc Vinh', 'I need your support', '0909367216', '2024-05-20 16:45:50.000000'),
(2602, 'your welcome', 'bellpham97@gmail.com', 'Pham Hung Quoc Vinh', 'thanks you', '0909367216', '2024-05-20 16:53:09.000000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contacts_seq`
--

CREATE TABLE `contacts_seq` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `contacts_seq`
--

INSERT INTO `contacts_seq` (`next_val`) VALUES
(151);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `authentication_type` enum('DATABASE','GOOGLE','FACEBOOK') DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `email_verified` tinyint(1) DEFAULT 1,
  `enabled` tinyint(1) DEFAULT 1,
  `full_name` varchar(64) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `phone_number` varchar(12) DEFAULT NULL,
  `phone_verified` tinyint(1) DEFAULT 1,
  `photo` varchar(1024) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `reset_password_token` varchar(30) DEFAULT NULL,
  `verification_code` varchar(64) DEFAULT NULL,
  `ward` varchar(255) DEFAULT NULL,
  `staff` tinyint(1) DEFAULT 0,
  `points` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customers`
--

INSERT INTO `customers` (`id`, `created_on`, `updated_on`, `version`, `address`, `authentication_type`, `city`, `district`, `email`, `email_verified`, `enabled`, `full_name`, `gender`, `password`, `phone_number`, `phone_verified`, `photo`, `postal_code`, `reset_password_token`, `verification_code`, `ward`, `staff`, `points`) VALUES
(2, NULL, NULL, 49, NULL, 'DATABASE', NULL, NULL, 'cus4@ymail.com', 0, 1, 'Customer 4', NULL, '$2a$10$O3SESrrtg36Ej0k4q.KGS.8j2WnDh.rbic8ccJmUcheiSmUWp000S', '0987665332', 0, NULL, NULL, NULL, 'lR69zWQcQrthTx66KiHnWHwfdZk2TV9pav6DCCJdZI1bc8h8BjHzCirY4gExrGhP', NULL, 1, 26),
(3, NULL, NULL, 1, NULL, 'DATABASE', NULL, NULL, 'cusship@ymail.com', 0, 1, 'Customer Ship', NULL, '$2a$10$thorS9wQVsqq12sMabo5Iuk6LWWTSmqqasDJHTujun29s51NCIIMK', '0987665332', 0, NULL, NULL, NULL, 'ieoqmka2UNhrCyMyUFHa6RWs2ZDDLGitSao10jpkKlSUZmah6Z0R6v21ibeSp9kq', NULL, 0, NULL),
(18, NULL, NULL, 1, NULL, 'DATABASE', NULL, NULL, 'vinh@gmail.com', 0, 1, '123', NULL, '$2a$10$5ZmoWTjh0Tan98h3RD35OOTox9FGp4FoLWT56i9/cjea2b7y7Nnnu', '0123123123', 0, NULL, NULL, NULL, 'ElQQq5yvptvr9AYxwOYL4AtAw2YIzDVOvGp87dT93QaHSkErqCxrTn00DWtZbYn9', NULL, 0, 19),
(19, NULL, NULL, 0, '123', NULL, NULL, NULL, 'bell@gmail.com', 0, 1, 'bell', 'MALE', '$2a$10$1LGPqmvft1JLe77ydwUH3uc0fMJbZ1rWSacc3thN7Nn/8tNd5Fv3i', '09093821728', 0, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(24, NULL, NULL, 46, NULL, 'DATABASE', NULL, NULL, 'bellpham97@gmail.com', 0, 1, 'VInh', NULL, '$2a$10$mjW.Q85lkQy24yv1gfbEheiZPTyDOb0ey1G80y/.lwBzpxq6qtYiK', '0909362716', 0, NULL, NULL, NULL, 'SaP6kQxcaIxynM77yRUMGXzMJJfPXLc8umoO0jYXzHLaAFF2NyWjfeUhXLWioLrK', NULL, 0, 13),
(25, NULL, NULL, 0, NULL, 'DATABASE', NULL, NULL, 'staff2@gmail.com', 0, 1, 'vinh', NULL, '$2a$10$Y1Vsx9b6.Npfppb52nTO0.CYuJ6bFfxgoRSICHzkJ/5BhZ1gvZKUe', '0909367216', 0, NULL, NULL, NULL, 'eupGW31N7BFh46WKUxhU1uIvl7M9IV4adFnskXqzXVMn2LdfNhIr6Fmh3u16B4Y9', NULL, 1, NULL),
(26, NULL, NULL, 0, NULL, 'DATABASE', NULL, NULL, 'cus1@gmail.com', 0, 1, 'teo', NULL, '$2a$10$6HEQypiamyOF0KoPbxywxuFZCKy7zT7lz9DrwIFJRTXV6WBbd7K8e', '1113', 0, NULL, NULL, NULL, 'p56IIzlXFnuQ6ysNiQsAXl8F6dkachNFiMk0Hht9HUXJlWFNSx1A0vWDfV32hglO', NULL, 0, NULL),
(29, NULL, NULL, 0, NULL, 'DATABASE', NULL, NULL, 'cus3@yopmail.com', 0, 1, 'tien', NULL, '$2a$10$2sUcjFJhkymHvLgH2r69k.MsdWnJ30k7C7F52Flzjp2oqbC5o3Kh.', 'fgufyug', 0, NULL, NULL, NULL, 'bVT0z5vESw28CY9TUAk0T7ndlmDPml5oWO3q254ksMZcT4F6A54ecbBdfYamDtIC', NULL, 0, NULL),
(30, NULL, NULL, 4, NULL, 'DATABASE', NULL, NULL, 'cus2@yopmail.com', 0, 1, 'Pham Hung Quoc Tien', NULL, '$2a$10$9M6m/l456cEaaKTZgdd13OrIdWMOGx9pLWgbTHElEQ0JCi0R/pgJe', '0909367123', 0, NULL, NULL, NULL, 'kJGKBwgXfEnsCK6pM2gtsqm7o6KkholAAZRR8811XVqWoJzqbZ47OQujGvpVrhQf', NULL, 0, NULL),
(31, NULL, NULL, 0, NULL, 'DATABASE', NULL, NULL, 'cus6@yopmail.com', 0, 1, 'Pham Hung Quoc Vinh', NULL, '$2a$10$SC6A/xUrVgBt8AoDo7C0S.9Nwro5e7myzMWNdsUELA2Y02UDSDv0y', '0909367216', 0, NULL, NULL, NULL, 'Q9vmoFmfLxvVM1xld8JsNivqyqyjlgI563Z3YwuasahLaZ8sdPvXG5IhdG6fC5XE', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `income`
--

CREATE TABLE `income` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `day` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `income`
--

INSERT INTO `income` (`id`, `created_on`, `updated_on`, `version`, `day`) VALUES
(8, NULL, NULL, 0, '2024-06-03 14:00:31.000000'),
(9, NULL, NULL, 0, '2024-06-04 08:45:26.000000'),
(10, NULL, NULL, 0, '2024-06-05 14:54:58.000000'),
(11, NULL, NULL, 0, '2024-06-07 12:47:57.000000'),
(12, NULL, NULL, 0, '2024-06-15 19:24:08.000000'),
(13, NULL, NULL, 0, '2024-06-18 07:39:28.000000'),
(14, NULL, NULL, 0, '2024-06-19 14:06:26.000000'),
(15, NULL, NULL, 0, '2024-06-20 00:07:37.000000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `income_item`
--

CREATE TABLE `income_item` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `price` decimal(10,1) DEFAULT NULL,
  `sold_quantity` decimal(10,1) DEFAULT NULL,
  `income_id` bigint(20) DEFAULT NULL,
  `ingredient_id` bigint(20) DEFAULT NULL,
  `order_item_id` bigint(20) DEFAULT NULL,
  `half_portion` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `income_item`
--

INSERT INTO `income_item` (`id`, `created_on`, `updated_on`, `version`, `price`, `sold_quantity`, `income_id`, `ingredient_id`, `order_item_id`, `half_portion`) VALUES
(39, NULL, NULL, 3, '10.0', '4.0', 8, 16, NULL, b'0'),
(40, NULL, NULL, 7, '90.0', '8.0', 8, 7, NULL, b'0'),
(41, NULL, NULL, 3, '99.0', '4.0', 8, 27, NULL, b'0'),
(42, NULL, NULL, 3, '34.0', '4.0', 8, 25, NULL, b'0'),
(43, NULL, NULL, 2, '8.0', '3.0', 8, 18, NULL, b'0'),
(44, NULL, NULL, 0, '15.0', '1.0', 8, 9, NULL, b'0'),
(45, NULL, NULL, 0, '89.0', '1.0', 8, 26, NULL, b'0'),
(46, NULL, NULL, 6, '79.0', '7.0', 8, 30, NULL, b'0'),
(47, NULL, NULL, 0, '400.0', '1.0', 8, 28, NULL, b'0'),
(48, NULL, NULL, 0, '20.0', '1.0', 8, 12, NULL, b'0'),
(49, NULL, NULL, 0, '8.0', '1.0', 9, 18, NULL, b'0'),
(50, NULL, NULL, 0, '10.0', '1.0', 9, 16, NULL, b'0'),
(51, NULL, NULL, 0, '400.0', '1.0', 9, 28, NULL, b'0'),
(52, NULL, NULL, 0, '34.0', '1.0', 9, 25, NULL, b'0'),
(53, NULL, NULL, 2, '79.0', '3.0', 10, 30, NULL, b'0'),
(54, NULL, NULL, 2, '90.0', '3.0', 10, 7, NULL, b'0'),
(55, NULL, NULL, 0, '8.0', '1.0', 11, 18, NULL, b'0'),
(56, NULL, NULL, 0, '99.0', '1.0', 11, 29, NULL, b'0'),
(57, NULL, NULL, 0, '20.0', '1.0', 11, 12, NULL, b'0'),
(58, NULL, NULL, 0, '99.0', '1.0', 11, 24, NULL, b'0'),
(59, NULL, NULL, 0, '15.0', '1.0', 12, 9, NULL, b'0'),
(60, NULL, NULL, 0, '90.0', '1.0', 12, 7, NULL, b'0'),
(61, NULL, NULL, 0, '7.0', '1.0', 13, 20, NULL, b'0'),
(62, NULL, NULL, 0, '8.0', '2.0', 13, 18, NULL, b'0'),
(63, NULL, NULL, 1, '10.0', '2.0', 13, 16, NULL, b'0'),
(64, NULL, NULL, 0, '9.0', '1.0', 13, 17, NULL, b'0'),
(65, NULL, NULL, 0, '100.0', '1.0', 13, 22, NULL, b'0'),
(66, NULL, NULL, 0, '89.0', '1.0', 13, 23, NULL, b'0'),
(67, NULL, NULL, 1, '89.0', '2.0', 13, 26, NULL, b'0'),
(68, NULL, NULL, 2, '34.0', '3.0', 13, 25, NULL, b'0'),
(69, NULL, NULL, 5, '79.0', '7.0', 13, 30, NULL, b'0'),
(70, NULL, NULL, 5, '90.0', '6.0', 13, 7, NULL, b'0'),
(71, NULL, NULL, 0, '20.0', '1.0', 13, 12, NULL, b'0'),
(72, NULL, NULL, 2, '15.0', '3.0', 13, 9, NULL, b'0'),
(73, NULL, NULL, 1, '99.0', '3.0', 13, 27, NULL, b'0'),
(74, NULL, NULL, 0, '400.0', '1.0', 13, 28, NULL, b'0'),
(75, NULL, NULL, 3, '90.0', '7.0', 14, 7, NULL, b'0'),
(76, NULL, NULL, 0, '8.0', '1.0', 14, 18, NULL, b'0'),
(77, NULL, NULL, 0, '10.0', '1.0', 14, 16, NULL, b'0'),
(78, NULL, NULL, 4, '15.0', '6.0', 14, 9, NULL, b'0'),
(79, NULL, NULL, 2, '20.0', '3.0', 14, 31, NULL, b'0'),
(80, NULL, NULL, 0, '34.0', '2.0', 14, 25, NULL, b'0'),
(81, NULL, NULL, 0, '99.0', '1.0', 14, 42, NULL, b'0'),
(82, NULL, NULL, 3, '79.0', '5.0', 15, 30, NULL, b'0'),
(83, NULL, NULL, 5, '10.0', '15.0', 15, 16, NULL, b'0'),
(84, NULL, NULL, 1, '34.0', '2.0', 15, 25, NULL, b'0'),
(85, NULL, NULL, 1, '89.0', '2.0', 15, 33, NULL, b'0'),
(86, NULL, NULL, 7, '20.0', '12.0', 15, 31, NULL, b'0'),
(87, NULL, NULL, 5, '15.0', '6.0', 15, 9, NULL, b'0'),
(88, NULL, NULL, 1, '15.0', '2.0', 15, 34, NULL, b'0'),
(89, NULL, NULL, 2, '59.0', '3.0', 15, 32, NULL, b'0'),
(90, NULL, NULL, 0, '89.0', '1.0', 15, 26, NULL, b'0'),
(91, NULL, NULL, 0, '20.0', '1.0', 15, 37, NULL, b'0'),
(92, NULL, NULL, 0, '99.0', '1.0', 15, 27, NULL, b'0'),
(93, NULL, NULL, 3, '9.0', '4.0', 15, 18, NULL, b'0'),
(94, NULL, NULL, 1, '1.0', '4.0', 15, 43, NULL, b'0');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ingredient`
--

CREATE TABLE `ingredient` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `ingredient_code` varchar(45) NOT NULL,
  `ingredient_name` varchar(45) NOT NULL,
  `photo` varchar(1024) DEFAULT NULL,
  `quantity_in_stock` decimal(10,2) DEFAULT NULL,
  `unit_of_measure` varchar(10) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `unit_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `half_portion_available` tinyint(1) DEFAULT 1,
  `weight` decimal(10,2) DEFAULT NULL,
  `order_items` varbinary(255) DEFAULT NULL,
  `status` enum('Available','OutofStock','Expired') DEFAULT NULL,
  `default_quantity` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `ingredient`
--

INSERT INTO `ingredient` (`id`, `created_on`, `updated_on`, `version`, `ingredient_code`, `ingredient_name`, `photo`, `quantity_in_stock`, `unit_of_measure`, `category_id`, `unit_id`, `price`, `description`, `half_portion_available`, `weight`, `order_items`, `status`, `default_quantity`) VALUES
(7, NULL, NULL, 19, 'Beef Steak XO', 'Beef Steak XO', 'QmVlZiBTdGVhayBYTw==', '99.00', NULL, 4, NULL, '90.00', 'Yummy', 0, '100.00', NULL, 'Available', NULL),
(8, NULL, NULL, 12, '1', 'Noodle', 'Tm9vZGxl', '100.00', NULL, 2, NULL, '19.00', 'Yummy', 0, '100.00', NULL, 'Available', NULL),
(9, NULL, NULL, 21, '123', 'Pork XO', 'UG9yayBYTw==', '29.00', NULL, 1, NULL, '15.00', '', 0, '100.00', NULL, 'Available', NULL),
(11, NULL, NULL, 15, '18', 'Fish Chilli', 'RmlzaCBDaGlsbGk=', '100.00', NULL, 2, NULL, '80.00', '', 0, '1.00', NULL, 'Available', NULL),
(12, NULL, NULL, 14, '19', 'Beef Muscle', 'QmVlZiBNdXNjbGU=', '106.00', NULL, 4, NULL, '20.00', '', 0, '100.00', NULL, 'Available', NULL),
(14, NULL, NULL, 9, '11', 'Mango Fish', 'RHJpZWQgRmlzaA==', '191.00', NULL, 2, NULL, '80.00', '', 0, '100.00', NULL, 'Available', NULL),
(16, NULL, NULL, 2, '1233', 'Lemon Juice', 'TGVtb24gSnVpY2U=', '89.00', NULL, 5, NULL, '10.00', 'Fresh', 0, '10.00', NULL, 'Available', NULL),
(17, NULL, NULL, 0, '456', 'Water Melon', 'V2F0ZXIgTWVsb24=', '100.00', NULL, 5, NULL, '9.00', 'Fresh', 0, '11.00', NULL, 'Available', NULL),
(18, NULL, NULL, 0, '999', 'Apple Juice', 'QXBwbGUgSnVpY2U=', '100.00', NULL, 5, NULL, '9.00', 'Fresh', 0, '11.00', NULL, 'Available', NULL),
(19, NULL, NULL, 0, '22', 'Carrot Juice', 'Q2Fycm90IEp1aWNl', '100.00', NULL, 5, NULL, '8.00', 'Fresh', 0, '11.00', NULL, 'Available', NULL),
(20, NULL, NULL, 0, '55', 'banana smoothie', 'YmFuYW5hIHNtb290aGll', '100.00', NULL, 5, NULL, '7.00', 'Fresh', 0, '22.00', NULL, 'Available', NULL),
(21, NULL, NULL, 0, 'q123', 'Soy milk hotpot', 'U295IG1pbGsgaG90cG90', '100.00', NULL, 8, NULL, '100.00', 'Yummy', 0, '22.00', NULL, 'Available', NULL),
(22, NULL, NULL, 0, '445', 'TomYum Hotpot', 'VG9tWXVtIEhvdHBvdA==', '100.00', NULL, 8, NULL, '100.00', 'yummy', 0, '24.00', NULL, 'Available', NULL),
(23, NULL, NULL, 0, '55', 'Vegan Hotpot', 'VmVnYW4gSG90cG90', '100.00', NULL, 8, NULL, '89.00', 'Vegan', 0, '222.00', NULL, 'Available', NULL),
(24, NULL, NULL, 0, '99', 'Tomato Soup', 'VG9tYXRvIFNvdXA=', '100.00', NULL, 8, NULL, '99.00', 'Yummy', 0, '33.00', NULL, 'Available', NULL),
(25, NULL, NULL, 3, '44', 'Crab Sticks', 'Q3JhYiBTdGlja3M=', '96.00', NULL, 6, NULL, '34.00', 'fresh', 0, '234.00', NULL, 'Available', NULL),
(26, NULL, NULL, 0, '555', 'Shirmp', 'U2hpcm1w', '100.00', NULL, 6, NULL, '89.00', 'fresh', 0, '500.00', NULL, 'Available', NULL),
(27, NULL, NULL, 0, '33', 'Oyster', 'T3lzdGVy', '100.00', NULL, 6, NULL, '99.00', 'fresh', 0, '500.00', NULL, 'Available', NULL),
(28, NULL, NULL, 0, '994', 'Lobster', 'TG9ic3Rlcg==', '100.00', NULL, 6, NULL, '400.00', 'fresh', 0, '100.00', NULL, 'Available', NULL),
(29, NULL, NULL, 0, '5554', 'Salmon', 'U2FsbW9u', '100.00', NULL, 2, NULL, '99.00', 'fresh', 0, '110.00', NULL, 'Available', NULL),
(30, NULL, NULL, 3, '909', 'Pork Belly Sliced', 'UG9yayBCZWxseSBTbGljZWQ=', '96.00', NULL, 1, NULL, '79.00', 'fresh', 0, '100.00', NULL, 'Available', NULL),
(31, NULL, NULL, 8, '111', 'Pork Dumpling', 'UG9yayBEdW1wbGluZw==', '88.00', NULL, 1, NULL, '20.00', 'Fresh', 0, '100.00', NULL, 'Available', NULL),
(32, NULL, NULL, 1, '111111', 'Pork Hindlet', 'UG9yayBIaW5kbGV0', '99.00', NULL, 1, NULL, '50.00', 'Fresh', 0, '100.00', NULL, 'Available', NULL),
(33, NULL, NULL, 1, '1233', 'Iberico Pork', 'SWJlcmljbyBQb3Jr', '99.00', NULL, 1, NULL, '89.00', 'fresh', 0, '100.00', NULL, 'Available', NULL),
(34, NULL, NULL, 0, '123123', 'Shumai Dumpling', 'U2h1bWFpIER1bXBsaW5n', '100.00', NULL, 1, NULL, '15.00', 'Yummy', 0, '100.00', NULL, 'Available', NULL),
(35, NULL, NULL, 0, '444', 'Signature Beef', 'U2lnbmF0dXJlIEJlZWY=', '100.00', NULL, 4, NULL, '99.00', 'Fresh', 0, '100.00', NULL, 'Available', NULL),
(36, NULL, NULL, 0, '4444', 'Exquisite Fatty Beef Slice', 'RXhxdWlzaXRlIEZhdHR5IEJlZWYgU2xpY2U=', '100.00', NULL, 4, NULL, '123.00', 'Fresh', 0, '100.00', NULL, 'Available', NULL),
(37, NULL, NULL, 0, '12332', 'Shrimp Dumpling', 'U2hyaW1wIER1bXBsaW5n', '100.00', NULL, 6, NULL, '20.00', 'Yummy', 0, '100.00', NULL, 'Available', NULL),
(38, NULL, NULL, 0, '5555', 'Combo Mushroom 1', 'Q29tYm8gTXVzaHJvb20gMQ==', '200.00', NULL, 10, NULL, '39.00', 'Fresh', 0, '200.00', NULL, 'Available', NULL),
(39, NULL, NULL, 0, '13333', 'Combo Mushroom 2', 'Q29tYm8gTXVzaHJvb20gMg==', '100.00', NULL, 10, NULL, '36.00', 'Fresh', 0, '100.00', NULL, 'Available', NULL),
(40, NULL, NULL, 0, '332', 'Combo Mushroom 3', 'Q29tYm8gTXVzaHJvb20gMw==', '111.00', NULL, 10, NULL, '34.00', 'Fresh', 0, '111.00', NULL, 'Available', NULL),
(41, NULL, NULL, 0, '3323', 'Tofu Skin', 'VG9mdSBTa2lu', '100.00', NULL, 10, NULL, '19.00', 'Fresh', 0, '100.00', NULL, 'Available', NULL),
(42, NULL, NULL, 1, '12999', 'Lamb Rolling', 'TGFtYiBSb2xsaW5n', '0.00', NULL, 4, NULL, '99.00', 'Fresh', 0, NULL, NULL, 'OutofStock', '1.00'),
(43, NULL, NULL, 1, 'drink1', 'Cola', 'Q29sYQ==', '0.00', NULL, 5, NULL, '1.00', 'cool', 0, NULL, NULL, 'OutofStock', '2.00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `order_time` datetime(6) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `ingredient_id` bigint(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `tips` double NOT NULL,
  `total` double NOT NULL,
  `table_id` bigint(20) DEFAULT NULL,
  `discount` double NOT NULL,
  `dish_name` varchar(255) DEFAULT NULL,
  `ordertime` datetime(6) DEFAULT NULL,
  `income_id` bigint(20) DEFAULT NULL,
  `tax` double NOT NULL,
  `total1` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `order_time`, `status`, `ingredient_id`, `email`, `full_name`, `payment_method`, `tips`, `total`, `table_id`, `discount`, `dish_name`, `ordertime`, `income_id`, `tax`, `total1`) VALUES
(146, NULL, NULL, NULL, 'cus4@ymail.com', 'pham hung quoc vinh', 'vnpay', 0, 108.9, 5, 0, NULL, '2024-06-03 19:49:40.000000', NULL, 9.9, 99),
(149, NULL, NULL, NULL, 'cus4@ymail.com', 'pham hung quoc vinh', 'paypal', 10, 29.8, 5, 0, NULL, '2024-06-04 08:45:26.000000', NULL, 1.8, 18),
(151, NULL, NULL, NULL, 'cus4@ymail.com', 'pham hung quoc vinh', 'vnpay', 10, 487.4, 10, 0, NULL, '2024-06-04 08:46:33.000000', NULL, 43.4, 434),
(167, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'paypal', 10, 195.9, 1, 0, NULL, '2024-06-05 14:54:58.000000', NULL, 16.9, 169),
(184, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'vnpay', 10, 195.9, 8, 0, NULL, '2024-06-05 23:10:00.000000', NULL, 16.9, 169),
(218, NULL, NULL, NULL, 'cus4@ymail.com', 'pham hung quoc vinh', 'paypal', 10, 258.6, 5, 0, NULL, '2024-06-07 12:47:56.000000', NULL, 22.6, 226),
(325, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'paypal', 5, 580.3, 1, 0, NULL, '2024-06-18 07:39:28.000000', NULL, 52.3, 523),
(329, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'vnpay', 10, 315.8, 5, 0, NULL, '2024-06-18 07:48:12.000000', NULL, 27.8, 278),
(332, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'vnpay', 10, 212.4, 5, 0, NULL, '2024-06-18 07:48:55.000000', NULL, 18.4, 184),
(336, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'vnpay', 5, 446.1, 5, 0, NULL, '2024-06-18 07:52:19.000000', NULL, 40.1, 401),
(339, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'vnpay', 5, 207.4, 5, 0, NULL, '2024-06-18 07:53:24.000000', NULL, 18.4, 184),
(346, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'paypal', 5, 777.2, 5, 0, NULL, '2024-06-18 08:07:42.000000', NULL, 70.2, 702),
(359, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'cash', 10, 124.4, 1, 0, NULL, '2024-06-18 09:32:24.000000', NULL, 10.4, 104),
(369, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'paypal', 5, 154.3, 1, 2.5, NULL, '2024-06-19 14:06:26.000000', NULL, 13.8, 138),
(372, NULL, NULL, NULL, 'cus4@ymail.com', 'pham hung quoc vinh', 'paypal', 5, 21.5, 1, 0, NULL, '2024-06-19 19:06:04.000000', NULL, 1.5, 15),
(375, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'paypal', 5, 42.8, 1, 0.7, NULL, '2024-06-19 21:53:16.000000', NULL, 3.5, 35),
(378, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'paypal', 10, 208, 1, 0, NULL, '2024-06-19 22:38:23.000000', NULL, 18, 180),
(379, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'cash', 10, 208, 1, 0, NULL, '2024-06-19 22:38:26.000000', NULL, 18, 180),
(384, NULL, NULL, NULL, 'cus4@ymail.com', 'minh tien', 'cash', 5, 241.5, 1, 0, NULL, '2024-06-19 22:46:29.000000', NULL, 21.5, 215),
(387, NULL, NULL, NULL, 'bellpham97@gmail.com', 'pham hung quoc vinh', 'vnpay', 5, 79.8, 1, 0, NULL, '2024-06-19 22:53:21.000000', NULL, 6.8, 68),
(394, NULL, NULL, NULL, 'cus4@ymail.com', 'phạm văn tèo', 'cash', 10, 118.9, 1, 0, NULL, '2024-06-19 23:06:56.000000', NULL, 9.9, 99),
(396, NULL, NULL, NULL, 'cus4@ymail.com', 'phạm văn tèo', 'cash', 10, 26.5, 1, 0, NULL, '2024-06-19 23:25:08.000000', NULL, 1.5, 15),
(404, NULL, NULL, NULL, 'cus4@ymail.com', 'pham hung quoc vinh', 'cash', 10, 32, 1, 0, NULL, '2024-06-19 23:44:36.000000', NULL, 2, 20),
(407, NULL, NULL, NULL, 'cus4@ymail.com', 'phạm văn tèo', 'cash', 5, 91.9, 1, 0, NULL, '2024-06-20 00:07:37.000000', NULL, 7.9, 79),
(411, NULL, NULL, NULL, 'bellpham97@gmail.com', 'phạm văn tèo', 'cash', 10, 178.3, 1, 0, NULL, '2024-06-20 00:17:11.000000', NULL, 15.3, 153),
(427, NULL, NULL, NULL, 'cus4@ymail.com', 'vinh', 'cash', 10, 48.5, 8, 0, NULL, '2024-06-20 09:03:31.000000', NULL, 3.5, 35),
(429, NULL, NULL, NULL, NULL, NULL, NULL, 0, 89, NULL, 0, NULL, '2024-06-20 09:33:35.000000', NULL, 8.9, 97.9),
(430, NULL, NULL, NULL, NULL, NULL, NULL, 0, 99, NULL, 0, NULL, '2024-06-20 09:37:06.000000', NULL, 9.9, 108.9),
(431, NULL, NULL, NULL, NULL, NULL, NULL, 0, 94, NULL, 0, NULL, '2024-06-20 09:55:59.000000', NULL, 9.4, 103.4),
(432, NULL, NULL, NULL, NULL, NULL, NULL, 0, 108, NULL, 0, NULL, '2024-06-20 09:57:52.000000', NULL, 10.8, 118.8),
(433, NULL, NULL, NULL, NULL, NULL, NULL, 0, 114, NULL, 0, NULL, '2024-06-20 10:27:23.000000', NULL, 11.4, 125.4),
(434, NULL, NULL, NULL, 'cus4@ymail.com', 'minh tien', 'cash', 10, 135.4, 1, 0, NULL, '2024-06-20 10:27:48.000000', NULL, 11.4, 114),
(435, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100, NULL, 0, NULL, '2024-06-20 10:29:56.000000', NULL, 10, 110),
(436, NULL, NULL, NULL, 'cus4@ymail.com', 'minh tien', 'cash', 0, 110, 1, 0, NULL, '2024-06-20 10:30:25.000000', NULL, 10, 100),
(437, NULL, NULL, NULL, NULL, NULL, NULL, 0, 100, NULL, 0, NULL, '2024-06-20 10:44:03.000000', NULL, 10, 110),
(438, NULL, NULL, NULL, 'cus4@ymail.com', 'vinh', 'cash', 5, 115, 1, 0, NULL, '2024-06-20 10:45:22.000000', NULL, 10, 100),
(439, NULL, NULL, NULL, NULL, NULL, NULL, 0, 242, NULL, 0, NULL, '2024-06-20 10:47:03.000000', NULL, 24.200000000000003, 266.2),
(440, NULL, NULL, NULL, 'cus4@ymail.com', 'minh tien', 'cash', 10, 276.2, 1, 0, NULL, '2024-06-20 10:48:24.000000', NULL, 24.2, 242),
(441, NULL, NULL, NULL, NULL, NULL, NULL, 0, 114, NULL, 0, NULL, '2024-06-20 10:54:45.000000', NULL, 11.4, 125.4),
(442, NULL, NULL, NULL, NULL, NULL, NULL, 0, 232, NULL, 0, NULL, '2024-06-20 10:55:57.000000', NULL, 23.200000000000003, 255.2),
(443, NULL, NULL, NULL, 'cus4@ymail.com', 'minh tien', 'cash', 0, 251.2, 5, 4, NULL, '2024-06-20 10:57:12.000000', NULL, 23.2, 232),
(444, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50, NULL, 0, NULL, '2024-06-20 11:00:24.000000', NULL, 5, 55),
(445, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50, NULL, 0, NULL, '2024-06-20 11:02:11.000000', NULL, 5, 55),
(446, NULL, NULL, NULL, 'cus4@ymail.com', 'hhaaoo', 'cash', 5, 60, 5, 0, NULL, '2024-06-20 11:03:08.000000', NULL, 5, 50),
(447, NULL, NULL, NULL, NULL, NULL, NULL, 0, 242, NULL, 0, NULL, '2024-06-20 12:24:19.000000', NULL, 24.200000000000003, 266.2),
(448, NULL, NULL, NULL, 'cus4@ymail.com', 'phạm văn tèo', 'cash', 0, 266.2, 8, 0, NULL, '2024-06-20 12:25:29.000000', NULL, 24.2, 242),
(449, NULL, NULL, NULL, NULL, NULL, NULL, 0, 54, NULL, 0, NULL, '2024-06-20 12:56:50.000000', NULL, 5.4, 59.4),
(450, NULL, NULL, NULL, 'bellpham97@gmail.com', 'phạm văn tèo', 'paypal', 0, 53.4, 5, 6, NULL, '2024-06-20 12:59:06.000000', NULL, 5.4, 54),
(451, NULL, NULL, NULL, 'bellpham97@gmail.com', 'phạm văn tèo', 'paypal', 0, 53.4, 5, 6, NULL, '2024-06-20 12:59:09.000000', NULL, 5.4, 54),
(452, NULL, NULL, NULL, 'bellpham97@gmail.com', 'phạm văn tèo', 'paypal', 0, 53.4, 5, 6, NULL, '2024-06-20 12:59:15.000000', NULL, 5.4, 54),
(453, NULL, NULL, NULL, 'bellpham97@gmail.com', 'phạm văn tèo', 'cash', 0, 53.4, 5, 6, NULL, '2024-06-20 12:59:21.000000', NULL, 5.4, 54),
(454, NULL, NULL, NULL, NULL, NULL, NULL, 0, 209, NULL, 0, NULL, '2024-06-20 13:02:25.000000', NULL, 20.900000000000002, 229.9),
(455, NULL, NULL, NULL, NULL, NULL, NULL, 0, 94, NULL, 0, NULL, '2024-06-20 13:04:53.000000', NULL, 9.4, 103.4),
(456, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, NULL, 0, NULL, '2024-06-20 13:12:41.000000', NULL, 0.2, 2.2),
(457, NULL, NULL, NULL, 'tien@gmail.com', 'tien', 'cash', 0, 2.2, 1, 0, NULL, '2024-06-20 13:13:37.000000', NULL, 0.2, 2),
(458, NULL, NULL, NULL, 'tien@gmail.com', 'tien', 'cash', 0, 2.2, 1, 0, NULL, '2024-06-20 13:13:40.000000', NULL, 0.2, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_item`
--

CREATE TABLE `order_item` (
  `id` bigint(20) NOT NULL,
  `price` decimal(38,2) DEFAULT NULL,
  `quantity` decimal(38,2) DEFAULT NULL,
  `ingredient_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `half_portion` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_item`
--

INSERT INTO `order_item` (`id`, `price`, `quantity`, `ingredient_id`, `order_id`, `created_on`, `updated_on`, `version`, `half_portion`) VALUES
(113, '7.00', '1.00', 20, 325, NULL, NULL, 0, b'0'),
(114, '8.00', '2.00', 18, 325, NULL, NULL, 0, b'0'),
(115, '10.00', '1.00', 16, 325, NULL, NULL, 0, b'0'),
(116, '9.00', '1.00', 17, 325, NULL, NULL, 0, b'0'),
(117, '100.00', '1.00', 22, 325, NULL, NULL, 0, b'0'),
(118, '89.00', '1.00', 23, 325, NULL, NULL, 0, b'0'),
(119, '89.00', '1.00', 26, 325, NULL, NULL, 0, b'0'),
(120, '34.00', '1.00', 25, 325, NULL, NULL, 0, b'0'),
(121, '79.00', '1.00', 30, 325, NULL, NULL, 0, b'0'),
(122, '90.00', '1.00', 7, 325, NULL, NULL, 0, b'0'),
(123, '79.00', '2.00', 30, 329, NULL, NULL, 0, b'0'),
(124, '10.00', '1.00', 16, 329, NULL, NULL, 0, b'0'),
(125, '20.00', '1.00', 12, 329, NULL, NULL, 0, b'0'),
(126, '90.00', '1.00', 7, 329, NULL, NULL, 0, b'0'),
(127, '15.00', '1.00', 9, 332, NULL, NULL, 0, b'0'),
(128, '79.00', '1.00', 30, 332, NULL, NULL, 0, b'0'),
(129, '90.00', '1.00', 7, 332, NULL, NULL, 0, b'0'),
(130, '99.00', '2.00', 27, 336, NULL, NULL, 0, b'0'),
(131, '34.00', '1.00', 25, 336, NULL, NULL, 0, b'0'),
(132, '79.00', '1.00', 30, 336, NULL, NULL, 0, b'0'),
(133, '90.00', '1.00', 7, 336, NULL, NULL, 0, b'0'),
(134, '15.00', '1.00', 9, 339, NULL, NULL, 0, b'0'),
(135, '79.00', '1.00', 30, 339, NULL, NULL, 0, b'0'),
(136, '90.00', '1.00', 7, 339, NULL, NULL, 0, b'0'),
(137, '400.00', '1.00', 28, 346, NULL, NULL, 0, b'0'),
(138, '99.00', '1.00', 27, 346, NULL, NULL, 0, b'0'),
(139, '34.00', '1.00', 25, 346, NULL, NULL, 0, b'0'),
(140, '79.00', '1.00', 30, 346, NULL, NULL, 0, b'0'),
(141, '90.00', '1.00', 7, 346, NULL, NULL, 0, b'0'),
(142, '89.00', '1.00', 26, 359, NULL, NULL, 0, b'0'),
(143, '15.00', '1.00', 9, 359, NULL, NULL, 0, b'0'),
(144, '90.00', '1.00', 7, 369, NULL, NULL, 0, b'0'),
(145, '8.00', '1.00', 18, 369, NULL, NULL, 0, b'0'),
(146, '10.00', '1.00', 16, 369, NULL, NULL, 0, b'0'),
(147, '15.00', '2.00', 9, 369, NULL, NULL, 0, b'0'),
(148, '15.00', '1.00', 9, 372, NULL, NULL, 0, b'0'),
(149, '20.00', '1.00', 31, 375, NULL, NULL, 0, b'0'),
(150, '15.00', '1.00', 9, 375, NULL, NULL, 0, b'0'),
(151, '90.00', '2.00', 7, 378, NULL, NULL, 0, b'0'),
(152, '90.00', '2.00', 7, 379, NULL, NULL, 0, b'0'),
(153, '20.00', '1.00', 31, 384, NULL, NULL, 0, b'0'),
(154, '15.00', '1.00', 9, 384, NULL, NULL, 0, b'0'),
(155, '90.00', '2.00', 7, 384, NULL, NULL, 0, b'0'),
(156, '34.00', '2.00', 25, 387, NULL, NULL, 0, b'0'),
(157, '99.00', '1.00', 42, 394, NULL, NULL, 0, b'0'),
(158, '15.00', '1.00', 9, 396, NULL, NULL, 0, b'0'),
(159, '20.00', '1.00', 31, 404, NULL, NULL, 0, b'0'),
(160, '79.00', '1.00', 30, 407, NULL, NULL, 0, b'0'),
(161, '10.00', '1.00', 16, 411, NULL, NULL, 0, b'0'),
(162, '34.00', '1.00', 25, 411, NULL, NULL, 0, b'0');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_reset_token`
--

CREATE TABLE `password_reset_token` (
  `id` bigint(20) NOT NULL,
  `expiry_date` datetime(6) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) NOT NULL,
  `content` longtext DEFAULT NULL,
  `create_at` varchar(64) DEFAULT NULL,
  `created_actor` varchar(1024) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `user_seen` int(11) DEFAULT NULL,
  `archived` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `posts`
--

INSERT INTO `posts` (`id`, `content`, `create_at`, `created_actor`, `image`, `title`, `user_seen`, `archived`) VALUES
(1, '<header class=\"mb-4 entry-header\" style=\"border: 0px solid rgb(230, 230, 230);\"><h1 class=\"entry-title mb-2\" style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); text-align: justify; border: 0px solid rgb(230, 230, 230); font-size: 2.625rem; font-weight: inherit; margin-right: 0px; margin-left: 0px; font-family: &quot;Domaine Display&quot;, Georgia, Cambria, &quot;Times New Roman&quot;, Times, serif; --tw-text-opacity: 1; line-height: 1.125;\">Avocado Caesar Green Beans</h1><div style=\"text-align: justify;\"><font color=\"#000000\"><span style=\"caret-color: rgb(0, 0, 0);\"><br></span></font></div></header><div class=\"mb-6 entry-content italic\" style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); border: 0px solid rgb(230, 230, 230); font-style: italic;\"><div style=\"text-align: justify;\">Grab a bag of green beans, blitz up a quick avocado caesar, toast some panko, and let’s go! This is some type of magic.</div></div><div class=\"entry-content\" style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); border: 0px solid rgb(230, 230, 230);\"><div class=\"tasty-recipes-quick-links\" style=\"border: 0px solid rgb(230, 230, 230); margin-bottom: 1rem; text-align: center;\"><a class=\"tasty-recipes-jump-link\" href=\"https://pinchofyum.com/avocado-caesar-green-beans#tasty-recipes-96630-jump-target\" style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); text-decoration: inherit; padding: 0.75rem 0.5rem; --tw-bg-opacity: 1; --tw-text-opacity: 1; background-color: rgb(247 247 247/var(--tw-bg-opacity)); display: block; font-family: ConsulSans-750, system-ui, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, Arial, &quot;Noto Sans&quot;, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 0.875rem; letter-spacing: 0.1em; line-height: 0.75rem; text-transform: uppercase;\">JUMP TO RECIPE</a></div><figure class=\"wp-block-image size-full\" style=\"border: 0px solid rgb(230, 230, 230); margin-bottom: 1.5rem; height: 891.046875px; width: 653.296875px;\"><div class=\"tasty-pins-banner-container\" style=\"border: 0px solid rgb(230, 230, 230); margin-bottom: 20px; position: relative; width: fit-content;\"><a class=\"tasty-pins-banner-image-link\" data-pin-custom=\"true\" data-pin-log=\"button_pinit\" data-pin-href=\"https://www.pinterest.com/pin/create/button?guid=gLRbamq6zXh0-1&amp;url=https%3A%2F%2Fpinchofyum.com%2Favocado-caesar-green-beans&amp;media=https%3A%2F%2Fpinchofyum.com%2Fwp-content%2Fuploads%2FAvocado-Caesar-Green-Beans-finished.jpg&amp;description=Avocado%20Caesar%20Green%20Beans%20Recipe%20-%20Pinch%20of%20Yum\" style=\"border: 0px solid rgb(230, 230, 230); color: rgb(0, 0, 0); text-decoration: inherit; cursor: pointer; display: flex; font-size: 14px; font-weight: 700; letter-spacing: 1px; line-height: 1.8em; text-transform: uppercase; flex-direction: column;\"><img decoding=\"async\" width=\"1600\" height=\"2133\" data-pin-url=\"https://pinchofyum.com/avocado-caesar-green-beans?tp_image_id=96656&amp;pin_title=QXZvY2FkbyBDYWVzYXIgR3JlZW4gQmVhbnM%3D&amp;pin_description=VGhlc2UgQXZvY2FkbyBDYWVzYXIgR3JlZW4gQmVhbnMgYXJlIHNvbWUgdHlwZSBvZiBtYWdpYyEgVGVuZGVyIGdyZWVuIGJlYW5zLCBhIHppcHB5IGF2b2NhZG8gY2Flc2FyLCBhbmQgdG9hc3R5IHBhbmtvIGFsbCBvdmVyIHRvcC4%3D\" data-pin-description=\"These Avocado Caesar Green Beans are some type of magic! Tender green beans, a zippy avocado caesar, and toasty panko all over top.\" data-pin-title=\"Avocado Caesar Green Beans\" loading=\"eager\" src=\"https://pinchofyum.com/wp-content/uploads/Avocado-Caesar-Green-Beans-finished.jpg\" alt=\"Caesar green beans on a plate with crispy panko.\" class=\"wp-image-96656\" srcset=\"https://pinchofyum.com/wp-content/uploads/Avocado-Caesar-Green-Beans-finished.jpg 1600w, https://pinchofyum.com/wp-content/uploads/Avocado-Caesar-Green-Beans-finished-225x300.jpg 225w, https://pinchofyum.com/wp-content/uploads/Avocado-Caesar-Green-Beans-finished-960x1280.jpg 960w, https://pinchofyum.com/wp-content/uploads/Avocado-Caesar-Green-Beans-finished-768x1024.jpg 768w, https://pinchofyum.com/wp-content/uploads/Avocado-Caesar-Green-Beans-finished-1152x1536.jpg 1152w, https://pinchofyum.com/wp-content/uploads/Avocado-Caesar-Green-Beans-finished-1536x2048.jpg 1536w, https://pinchofyum.com/wp-content/uploads/Avocado-Caesar-Green-Beans-finished-640x853.jpg 640w, https://pinchofyum.com/wp-content/uploads/Avocado-Caesar-Green-Beans-finished-150x200.jpg 150w, https://pinchofyum.com/cdn-cgi/image/width=480,height=99999,fit=scale-down/wp-content/uploads/Avocado-Caesar-Green-Beans-finished.jpg 480w, https://pinchofyum.com/cdn-cgi/image/width=680,height=99999,fit=scale-down/wp-content/uploads/Avocado-Caesar-Green-Beans-finished.jpg 680w, https://pinchofyum.com/cdn-cgi/image/width=1080,height=99999,fit=scale-down/wp-content/uploads/Avocado-Caesar-Green-Beans-finished.jpg 1080w\" sizes=\"(min-width: 1220px) 653px, (min-width: 780px) calc(51.67vw + 33px), calc(100vw - 32px)\" style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); display: block; height: auto; max-width: 100%; margin-bottom: 0px; padding-bottom: 0px;\"></a><a data-pin-custom=\"true\" class=\"tasty-pins-banner\" data-pin-log=\"button_pinit\" data-pin-href=\"https://www.pinterest.com/pin/create/button?guid=gLRbamq6zXh0-2&amp;url=https%3A%2F%2Fpinchofyum.com%2Favocado-caesar-green-beans&amp;media=https%3A%2F%2Fpinchofyum.com%2Fwp-content%2Fuploads%2FAvocado-Caesar-Green-Beans-finished.jpg&amp;description=Avocado%20Caesar%20Green%20Beans%20Recipe%20-%20Pinch%20of%20Yum\" style=\"border: 0px solid rgb(230, 230, 230); color: rgb(115, 64, 96); cursor: pointer; display: flex; font-size: 14px; font-weight: 700; letter-spacing: 1px; line-height: 1.8em; text-transform: uppercase; align-items: center; bottom: 0px; justify-content: center; left: 0px; padding-bottom: 1em; padding-top: 1em; position: absolute; right: 0px; background-color: rgba(255, 255, 255, 0.68);\"><svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 42 27.3\"><g><path d=\"M8.9,17.8c-.4,1.2-.7,2.4-1,3.5A13.8,13.8,0,0,1,5,27.1l-.3.2L4.5,27a17.3,17.3,0,0,1,.3-6.8C5.5,17.8,6,15.4,6.6,13a1.3,1.3,0,0,0-.1-.6,5.9,5.9,0,0,1,.2-4.7A2.8,2.8,0,0,1,9,6.1a2.1,2.1,0,0,1,2.2,1.7A5,5,0,0,1,11,9.9c-.3,1.3-.7,2.5-1.1,3.8a2.5,2.5,0,0,0,.7,2.8,3,3,0,0,0,3,.3A4.3,4.3,0,0,0,15.8,15a10,10,0,0,0,1.5-4.7,11.3,11.3,0,0,0,0-2.6,5.4,5.4,0,0,0-3.6-4.6A8.3,8.3,0,0,0,5.8,4.3a7.1,7.1,0,0,0-2.6,7.3A4.8,4.8,0,0,0,4,13.2a1.2,1.2,0,0,1,.3,1.1L4,15.4c-.2.4-.4.6-.9.4A4.8,4.8,0,0,1,1,13.9,8.2,8.2,0,0,1,0,9.3,10,10,0,0,1,8,.4a11.7,11.7,0,0,1,7.8.6,8.7,8.7,0,0,1,5.3,6.8,11.3,11.3,0,0,1-.9,6.5,8.8,8.8,0,0,1-2.8,3.8,7,7,0,0,1-5.7,1.5A3.8,3.8,0,0,1,8.9,17.8Z\" fill=\"currentColor\"></path><path d=\"M27.1,22.5l-1.4,1a4.1,4.1,0,0,1-3.2.7,2.3,2.3,0,0,1-2.1-2.5,11.3,11.3,0,0,1,.6-3.6c.5-2.2,1.1-4.5,1.7-6.7.2-.6.2-.7.9-.7h1.9c.6,0,.7.1.6.7l-1.8,6.8L24,20.1a.8.8,0,0,0,0,.7.9.9,0,0,0,1.1.8,2.2,2.2,0,0,0,1.4-.6,6.8,6.8,0,0,0,1.8-3.2c.5-2.1,1.1-4.2,1.6-6.3s.3-.8,1-.8h2c.4,0,.5.2.4.6s-.1.5-.1.8l.2-.3a5.4,5.4,0,0,1,4.2-1.4,3,3,0,0,1,2.7,3,7.8,7.8,0,0,1-.4,2.2c-.3,1.4-.6,2.8-1,4.2v.5a1.2,1.2,0,0,0,1.9,1.1l.2-.2,1,1.3-.9.8a4.2,4.2,0,0,1-3.4.9,2.4,2.4,0,0,1-2.3-2.7,18.8,18.8,0,0,1,.5-3.3c.2-1.1.5-2.1.8-3.2v-.8a1.2,1.2,0,0,0-1.1-1.1A3,3,0,0,0,33,14.3a7.1,7.1,0,0,0-1.1,2.5c-.5,2.2-1.1,4.4-1.6,6.6-.2.5-.3.6-.8.6H27.4c-.5,0-.6-.2-.5-.7A3.1,3.1,0,0,1,27.1,22.5Z\" fill=\"currentColor\"></path><path d=\"M25.7,5.4a1.7,1.7,0,0,1,1.7,2,2.8,2.8,0,0,1-2.2,2.2,1.7,1.7,0,0,1-2-2.1A2.5,2.5,0,0,1,25.7,5.4Z\" fill=\"currentColor\"></path></g></svg><span style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-top: 4px;\">THIS RECIPE</span></a></div><div class=\"wp-block-group post-toc\" style=\"border: 0px solid rgb(230, 230, 230); --tw-bg-opacity: 1; background-color: rgb(247 247 247/var(--tw-bg-opacity)); margin-bottom: 3rem; padding: 1.5rem;\"><div class=\"wp-block-group__inner-container is-layout-constrained wp-block-group-is-layout-constrained\" style=\"border: 0px solid rgb(230, 230, 230);\"><h2 class=\"wp-block-heading\" id=\"h-in-this-post\" style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); font-size: 1.5625em; margin-right: 0px; margin-bottom: 1rem; margin-left: 0px; --tw-text-opacity: 1; font-family: ConsulSans-750, system-ui, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, Arial, &quot;Noto Sans&quot;, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; letter-spacing: 0.025em; line-height: 1.25;\">In This Post</h2><div class=\"wp-block-columns is-layout-flex wp-container-core-columns-is-layout-8 wp-block-columns-is-layout-flex\" style=\"row-gap: 1rem; column-gap: 1rem; border: 0px solid rgb(230, 230, 230); display: flex; flex-wrap: wrap; align-items: flex-start;\"><div class=\"wp-block-column is-layout-flow wp-block-column-is-layout-flow\" style=\"border: 0px solid rgb(230, 230, 230); margin: 0px; flex-basis: 0px; flex-grow: 1;\"><ul style=\"border-width: 0px; border-style: solid; border-color: rgb(242 242 242/var(--tw-border-opacity)); list-style: none; margin: 0px; padding: 0px 0px 0px 1rem; --tw-border-opacity: 1; counter-reset: li 0; position: relative;\"><li style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem;\"><a href=\"https://pinchofyum.com/avocado-caesar-green-beans#tasty-recipes-96630-jump-target\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: none; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all; font-size: 1.063rem;\">Jump To The Recipe</a></li><li style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem;\"><a href=\"https://pinchofyum.com/avocado-caesar-green-beans#why-i-love-this\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: none; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all; font-size: 1.063rem;\">Why I Love This Recipe</a></li><li style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem;\"><a href=\"https://pinchofyum.com/avocado-caesar-green-beans#how-to\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: none; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all; font-size: 1.063rem;\">Visual Walk-Through of the Recipe</a></li></ul></div><div class=\"wp-block-column is-layout-flow wp-block-column-is-layout-flow\" style=\"border: 0px solid rgb(230, 230, 230); margin: 0px; flex-basis: 0px; flex-grow: 1;\"><ul style=\"border-width: 0px; border-style: solid; border-color: rgb(242 242 242/var(--tw-border-opacity)); list-style: none; margin: 0px; padding: 0px 0px 0px 1rem; --tw-border-opacity: 1; counter-reset: li 0; position: relative;\"><li style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem;\"><a href=\"https://pinchofyum.com/avocado-caesar-green-beans#video\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: none; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all; font-size: 1.063rem;\">Video</a></li><li style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem;\"><a href=\"https://pinchofyum.com/avocado-caesar-green-beans#faq\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: none; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all; font-size: 1.063rem;\">Frequently Asked Questions</a></li><li style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem;\"><a href=\"https://pinchofyum.com/avocado-caesar-green-beans#comments\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: none; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all; font-size: 1.063rem;\">Ratings</a></li></ul></div></div></div></div><div class=\"wp-block-group lindsay-notes\" style=\"border: 0px solid rgb(230, 230, 230); --tw-bg-opacity: 1; background-color: rgb(247 247 247/var(--tw-bg-opacity)); margin-bottom: 3rem; padding: 1.5rem;\"><div class=\"wp-block-group__inner-container is-layout-constrained wp-block-group-is-layout-constrained\" style=\"border: 0px solid rgb(230, 230, 230);\"><h2 class=\"wp-block-heading\" id=\"why-i-love-this\" style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); font-size: 1.5625em; margin-right: 0px; margin-bottom: 1rem; margin-left: 0px; --tw-text-opacity: 1; font-family: ConsulSans-750, system-ui, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, Arial, &quot;Noto Sans&quot;, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; letter-spacing: 0.025em; line-height: 1.25;\">This Avocado Caesar + Green Beans Combo Is Magic.</h2><div class=\"wp-block-image lindsay-headshot is-style-rounded\" style=\"border: 0px solid rgb(230, 230, 230); margin-bottom: 1rem; float: right; margin-left: 1rem; width: 222px;\"><figure class=\"alignright size-large is-resized\" style=\"border: 0px solid rgb(230, 230, 230); margin-bottom: 0px;\"><img loading=\"lazy\" decoding=\"async\" width=\"960\" height=\"960\" data-pin-url=\"https://pinchofyum.com/avocado-caesar-green-beans?tp_image_id=94266&amp;pin_title=QXZvY2FkbyBDYWVzYXIgR3JlZW4gQmVhbnM%3D&amp;pin_description=VGhlc2UgQXZvY2FkbyBDYWVzYXIgR3JlZW4gQmVhbnMgYXJlIHNvbWUgdHlwZSBvZiBtYWdpYyEgVGVuZGVyIGdyZWVuIGJlYW5zLCBhIHppcHB5IGF2b2NhZG8gY2Flc2FyLCBhbmQgdG9hc3R5IHBhbmtvIGFsbCBvdmVyIHRvcC4%3D\" data-pin-description=\"These Avocado Caesar Green Beans are some type of magic! Tender green beans, a zippy avocado caesar, and toasty panko all over top.\" data-pin-title=\"Avocado Caesar Green Beans\" src=\"https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-960x960.jpg\" alt=\"\" class=\"wp-image-94266\" srcset=\"https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-960x960.jpg 960w, https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-300x300.jpg 300w, https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-183x183.jpg 183w, https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-768x768.jpg 768w, https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-1536x1536.jpg 1536w, https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-400x400.jpg 400w, https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-800x800.jpg 800w, https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-1200x1200.jpg 1200w, https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-96x96.jpg 96w, https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes-150x150.jpg 150w, https://pinchofyum.com/wp-content/uploads/Lindsay-Post-Notes.jpg 1600w, https://pinchofyum.com/cdn-cgi/image/width=480,height=99999,fit=scale-down/wp-content/uploads/Lindsay-Post-Notes.jpg 480w, https://pinchofyum.com/cdn-cgi/image/width=680,height=99999,fit=scale-down/wp-content/uploads/Lindsay-Post-Notes.jpg 680w\" sizes=\"(max-width: 960px) 100vw, 960px\" style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); display: block; height: auto; max-width: 100%; border-radius: 9999px; width: 222px;\"></figure></div><div style=\"text-align: justify;\">Like, we’re here to talk about green beans, but pick anything from the garden and dunk it in this sauce and it will be your favorite food all summer.</div><div style=\"text-align: justify;\">Bjork’s parents were over for dinner a few weeks ago and I made a batch of&nbsp;<a href=\"https://pinchofyum.com/ridiculously-good-air-fryer-chicken-breast\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: underline; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px;\">air fryer chicken</a>&nbsp;(because, what else?). We needed just one more thing to make it into a meal. I had a bag of green beans. I had a craving for this&nbsp;<a href=\"https://pinchofyum.com/avocado-kale-caesar-salad-sweet-potato-fries\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: underline; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px;\">avocado caesar dressing</a>. It was a perfect recipe meet-cute right there in a moment of pre-dinner chaos, and now it’s our summer meal formula.</div><div style=\"text-align: justify;\">The salty, bright creaminess of the caesar-like sauce gets all wrapped up with the tender, summery-fresh green beans and lil crispy bits on top and it’s just so good. Fun to look at, fun to eat, and a new summer favorite.</div><div class=\"wp-block-image\" style=\"border: 0px solid rgb(230, 230, 230); margin-bottom: 1.5rem;\"><figure class=\"aligncenter size-full is-resized\" style=\"border: 0px solid rgb(230, 230, 230); margin-bottom: 0px; height: 300px; width: 605.296875px; clear: both;\"><img loading=\"lazy\" decoding=\"async\" width=\"1600\" height=\"2133\" data-pin-url=\"https://pinchofyum.com/avocado-caesar-green-beans?tp_image_id=96641&amp;pin_title=QXZvY2FkbyBDYWVzYXIgR3JlZW4gQmVhbnM%3D&amp;pin_description=VGhlc2UgQXZvY2FkbyBDYWVzYXIgR3JlZW4gQmVhbnMgYXJlIHNvbWUgdHlwZSBvZiBtYWdpYyEgVGVuZGVyIGdyZWVuIGJlYW5zLCBhIHppcHB5IGF2b2NhZG8gY2Flc2FyLCBhbmQgdG9hc3R5IHBhbmtvIGFsbCBvdmVyIHRvcC4%3D\" data-pin-description=\"These Avocado Caesar Green Beans are some type of magic! Tender green beans, a zippy avocado caesar, and toasty panko all over top.\" data-pin-title=\"Avocado Caesar Green Beans\" src=\"https://pinchofyum.com/wp-content/uploads/Caesar-Green-Beans.jpg\" alt=\"Caesar green beans on a plate with air fried chicken.\" class=\"wp-image-96641\" srcset=\"https://pinchofyum.com/wp-content/uploads/Caesar-Green-Beans.jpg 1600w, https://pinchofyum.com/wp-content/uploads/Caesar-Green-Beans-225x300.jpg 225w, https://pinchofyum.com/wp-content/uploads/Caesar-Green-Beans-960x1280.jpg 960w, https://pinchofyum.com/wp-content/uploads/Caesar-Green-Beans-768x1024.jpg 768w, https://pinchofyum.com/wp-content/uploads/Caesar-Green-Beans-1152x1536.jpg 1152w, https://pinchofyum.com/wp-content/uploads/Caesar-Green-Beans-1536x2048.jpg 1536w, https://pinchofyum.com/wp-content/uploads/Caesar-Green-Beans-640x853.jpg 640w, https://pinchofyum.com/wp-content/uploads/Caesar-Green-Beans-150x200.jpg 150w, https://pinchofyum.com/cdn-cgi/image/width=480,height=99999,fit=scale-down/wp-content/uploads/Caesar-Green-Beans.jpg 480w, https://pinchofyum.com/cdn-cgi/image/width=680,height=99999,fit=scale-down/wp-content/uploads/Caesar-Green-Beans.jpg 680w, https://pinchofyum.com/cdn-cgi/image/width=1080,height=99999,fit=scale-down/wp-content/uploads/Caesar-Green-Beans.jpg 1080w\" sizes=\"(min-width: 1220px) 653px, (min-width: 780px) calc(51.67vw + 33px), calc(100vw - 32px)\" style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); display: block; height: 300px; max-width: 100%; margin-left: auto; margin-right: auto; object-fit: cover; width: 300px;\"></figure></div><div style=\"text-align: justify;\">This + any protein is kind of the meal formula for us at the moment. And I feel like you could replicate this formula with almost any garden vegetable! Grilled or roasted zucchini, asparagus, or fresh tender garden lettuce (like a real Caesar).</div><div style=\"text-align: justify;\">Easy proteins I usually turn to:</div><ul style=\"border-width: 0px 0px 0px 4px; border-style: solid; border-color: rgb(242 242 242/var(--tw-border-opacity)); list-style: none; margin: 2rem 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; --tw-border-opacity: 1; counter-reset: li 0; position: relative;\"><li style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem;\"><a href=\"https://pinchofyum.com/ridiculously-good-air-fryer-chicken-breast\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: underline; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all;\">Air fryer chicken</a>&nbsp;(my go-to)</li><li style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem;\"><a href=\"https://pinchofyum.com/ridiculously-good-air-fryer-salmon\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: underline; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all;\">Air fryer salmon</a></li><li style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem;\"><a href=\"https://pinchofyum.com/best-anytime-baked-chicken-meatballs\" style=\"border: 0px solid rgb(230, 230, 230); text-decoration: inherit; --tw-text-opacity: 1; text-decoration-line: underline; text-decoration-color: rgb(237, 182, 84); text-decoration-thickness: 2px; transition-duration: 0.6s; transition-timing-function: ease-in-out; transition-property: all;\">Baked chicken meatballs</a></li><li style=\"text-align: justify; border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem;\">Grilled brats or chicken sausages</li></ul><div style=\"text-align: justify;\">Finally, a special word of endorsement for the avocado caesar dressing in this recipe. No matter what veggie we serve it with, they&nbsp;<span style=\"border: 0px solid rgb(230, 230, 230); --tw-text-opacity: 1; color: rgb(26 26 26/var(--tw-text-opacity));\">absolutely love it</span>. I have heard the same from so many of you on Instagram – specifically that your&nbsp;<em style=\"border: 0px solid rgb(230, 230, 230);\">kids</em>&nbsp;like it! I do not know what it is about this sauce, but if you are feeding kids, I hope this sauce alone unlocks something for you at mealtime.</div><div style=\"text-align: justify;\">It’s lemony and tangy and finger-licking delicious with minimal ingredient usage. My favorite!</div><figure class=\"wp-block-image size-full lindsay-sig\" style=\"border: 0px solid rgb(230, 230, 230); margin-bottom: 0.5rem; margin-left: auto; height: 52px; width: fit-content;\"><img loading=\"lazy\" decoding=\"async\" width=\"178\" height=\"52\" data-pin-nopin=\"nopin\" data-pin-url=\"https://pinchofyum.com/avocado-caesar-green-beans?tp_image_id=93813&amp;pin_title=QXZvY2FkbyBDYWVzYXIgR3JlZW4gQmVhbnM%3D&amp;pin_description=VGhlc2UgQXZvY2FkbyBDYWVzYXIgR3JlZW4gQmVhbnMgYXJlIHNvbWUgdHlwZSBvZiBtYWdpYyEgVGVuZGVyIGdyZWVuIGJlYW5zLCBhIHppcHB5IGF2b2NhZG8gY2Flc2FyLCBhbmQgdG9hc3R5IHBhbmtvIGFsbCBvdmVyIHRvcC4%3D\" data-pin-description=\"These Avocado Caesar Green Beans are some type of magic! Tender green beans, a zippy avocado caesar, and toasty panko all over top.\" data-pin-title=\"Avocado Caesar Green Beans\" src=\"https://pinchofyum.com/wp-content/uploads/lindsay-signature-notes.png\" alt=\"\" class=\"wp-image-93813\" srcset=\"https://pinchofyum.com/wp-content/uploads/lindsay-signature-notes.png 178w, https://pinchofyum.com/wp-content/uploads/lindsay-signature-notes-150x44.png 150w\" sizes=\"(min-width: 1220px) 653px, (min-width: 780px) calc(51.67vw + 33px), calc(100vw - 32px)\" style=\"border: 0px solid rgb(230, 230, 230); display: block; height: auto; max-width: 100%; width: 177px;\"></figure></div></div></figure></div>', '2024-06-20 11:23:58', NULL, 'QXZvY2FkbyBCZWFucw==', 'Avocado Beans', 0, b'0'),
(452, '<div class=\"blog-item-top-wrapper\" style=\"margin-bottom: 50px; display: flex; flex-direction: column; color: rgb(54, 54, 54); font-family: &quot;Source Code Pro&quot;; font-size: 16px;\"><div class=\"blog-item-title\" style=\"order: 2;\"><h2 style=\"text-align: center; font-family: &quot;Raleway Semibold&quot;; line-height: 2.4rem; color: rgb(80, 73, 72); margin-top: 20px; margin-bottom: 10px; font-size: 2rem;\">The best Gelato in Venus restaurant</h2><h1 class=\"entry-title entry-title--large p-name\" itemprop=\"headline\" data-content-field=\"title\" style=\"text-align: justify; font-size: calc((var(--blog-item-title-font-font-size-value) - 1) * 1.2vw + 1rem); margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-family: var(--blog-item-title-font-font-family); font-style: var(--blog-item-title-font-font-style); line-height: var(--blog-item-title-font-line-height); letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform);\"><span style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">With Spring finally within reach, the rising temperatures and brighter weather increase the cravings for one of the most famous of all Italian delicacies: gelato.&nbsp; While gelato is, of course, a year-round passion in Italy, there is nothing better than enjoying the chilly treat on a warm afternoon.&nbsp;&nbsp;</span><br style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"></h1><h1 class=\"entry-title entry-title--large p-name\" itemprop=\"headline\" data-content-field=\"title\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; line-height: var(--blog-item-title-font-line-height); font-size: calc((var(--blog-item-title-font-font-size-value) - 1) * 1.2vw + 1rem); font-family: var(--blog-item-title-font-font-family); font-style: var(--blog-item-title-font-font-style); letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform); text-align: center;\"><img width=\"1000\" height=\"666\" src=\"https://www.effettoitaly.com/en/wp-content/uploads/2021/03/i-scream-you-scream-for-gelato.jpg\" class=\"img-responsive wp-post-image\" alt=\"I scream, you scream… for gelato\" srcset=\"https://www.effettoitaly.com/en/wp-content/uploads/2021/03/i-scream-you-scream-for-gelato.jpg 1000w, https://www.effettoitaly.com/en/wp-content/uploads/2021/03/i-scream-you-scream-for-gelato-300x200.jpg 300w, https://www.effettoitaly.com/en/wp-content/uploads/2021/03/i-scream-you-scream-for-gelato-768x512.jpg 768w, https://www.effettoitaly.com/en/wp-content/uploads/2021/03/i-scream-you-scream-for-gelato-390x260.jpg 390w\" sizes=\"(max-width: 1000px) 100vw, 1000px\" style=\"border: 0px; display: block; max-width: 100%; height: auto; color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start; cursor: default;\"></h1><h1 class=\"entry-title entry-title--large p-name\" itemprop=\"headline\" data-content-field=\"title\" style=\"text-align: center; font-size: calc((var(--blog-item-title-font-font-size-value) - 1) * 1.2vw + 1rem); margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-family: var(--blog-item-title-font-font-family); font-style: var(--blog-item-title-font-font-style); line-height: var(--blog-item-title-font-line-height); letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform);\"><div style=\"text-align: justify;\"><span style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start; font-style: var(--blog-item-title-font-font-style); letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform);\">While often referred to as “Italian ice cream,” there are differences.&nbsp; While the ingredients of both ice cream and gelato are roughly the same, gelato contains only 4% fat and ice cream contains 10%.&nbsp; Additionally, there are variations in texture and consistency as gelato is blended very slowly and only contains 10% air, while ice cream often contains 50%.&nbsp; Finally, gelato is kept at a warmer temperature than ice cream, which enhances the flavor.&nbsp;</span></div><br style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"><div style=\"text-align: justify;\"><span style=\"font-style: var(--blog-item-title-font-font-style); letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform); color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">An integral part of Italian food culture, gelato can be found in virtually every town in Italy.&nbsp; When searching out a gelateria, look for signs that say&nbsp;</span><em style=\"letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform); color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">gelato fatto en casa</em><span style=\"font-style: var(--blog-item-title-font-font-style); letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform); color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">&nbsp;(homemade),&nbsp;</span><em style=\"letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform); color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">produzione</em><span style=\"font-style: var(--blog-item-title-font-font-style); letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform); color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">&nbsp;</span><em style=\"letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform); color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">propia</em><span style=\"font-style: var(--blog-item-title-font-font-style); letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform); color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">&nbsp;(our own production), or&nbsp;</span><em style=\"letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform); color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">artiginale</em><span style=\"font-style: var(--blog-item-title-font-font-style); letter-spacing: var(--blog-item-title-font-letter-spacing); text-transform: var(--blog-item-title-font-text-transform); color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">&nbsp;(artisanal).&nbsp; In addition, try to avoid counter displays with mountainous heaps of puffed-up cream, in an array of bright and artificial colors.&nbsp; Gelato colors should be muted and reflect the natural hues of the food they represent.&nbsp;</span></div><br style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"><span style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">Order in a cone or cup, and feel free to choose more than one flavor. Some of most popular flavors in shops are:&nbsp;</span><br style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"><br style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"><ul style=\"margin-top: 0px; color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"><li><strong>Chocolates:</strong>&nbsp;<em>cioccolato fondante</em>&nbsp;(dark chocolate),&nbsp;<em>cioccolato al latte</em>&nbsp;(milk chocolate),&nbsp;<em>caffe</em>&nbsp;(coffee)</li><li><strong>Creams:</strong>&nbsp;<em>fior di latte</em>&nbsp;(sweet cream),&nbsp;<em>stracciatella&nbsp;</em>(chocolate chip),&nbsp;<em>crema&nbsp;</em>(French vanilla)</li><li><strong>Fruits:</strong>&nbsp;<em>limone</em>&nbsp;(lemon),&nbsp;<em>fragola</em>&nbsp;(strawberry),&nbsp;<em>pesca</em>&nbsp;(peach)</li><li><strong>Nuts:</strong>&nbsp;<em>pistacchio</em>&nbsp;(pistachio),&nbsp;<em>mandorla</em>&nbsp;(almond),&nbsp;<em>nocciola</em>&nbsp;(hazelnut)</li></ul><br style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"><span style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">The only way to find a true favorite is to give them all a try. Happy eating!</span><br style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"><br style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"><span style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">Ciao for now,</span><br style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"><br style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\"><span style=\"color: rgb(80, 73, 72); font-family: &quot;Raleway Regular&quot;; font-size: 20px; font-weight: 400; text-align: start;\">The Venus Italy Team</span><br></h1></div></div>', '2024-03-25 09:30:31', NULL, 'R2VsYXRvIEljZUNyZWFt', 'Gelato IceCream', 0, b'0'),
(453, '<div class=\"sqs-block html-block sqs-block-html\" data-block-type=\"2\" id=\"block-79797f69ea20b682e4fd\" style=\"position: relative; height: auto; padding: 0px 17px 17px; clear: none; color: rgba(26, 26, 26, 0.7); font-size: 18px; background-color: rgb(243, 241, 241);\"><div class=\"sqs-block-content\" style=\"outline: none;\"><div class=\"sqs-html-content\" style=\"outline: none; overflow-wrap: break-word; margin-top: 0px; margin-bottom: 0px;\"><h3 class=\"post-title entry-title\" itemprop=\"name\" style=\"margin: 10px 0px 8px; position: relative; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-variant-position: normal; font-stretch: normal; font-size: 24px; line-height: 1.25; color: rgb(34, 34, 34); text-align: center; text-transform: uppercase; letter-spacing: 3px; background-color: rgb(255, 255, 255);\"><br></h3><div class=\"post-body entry-content\" id=\"post-body-1320961758772203491\" itemprop=\"description articleBody\" style=\"margin: 0px; padding: 0px; width: 728px; overflow: hidden; color: rgb(34, 34, 34); font-size: 16px; letter-spacing: 0.5px; background-color: rgb(255, 255, 255);\"><div dir=\"ltr\" trbidi=\"on\" style=\"margin: 0px; padding: 0px;\"><div style=\"text-align: justify; margin: 0px; padding: 0px;\"><font face=\"Arial\">If you live in Nigeria, you are probably familiar with the Chicken sold at&nbsp;<b>Shoprite</b>-I feel the Shoprite at&nbsp;<b>Circle Mall</b>&nbsp;makes the best varieties of Chicken and I usually don\'\'t mind driving there to get some. Soon I got tired of driving there and realising that it was not fresh out of the oven/grill and decided to make my own so I can enjoy it just the way I like it!... this oven grilled chicken tastes almost the same if not better than the Shoprite one (lol), I made it for my in laws, they loved it! I make it every time for my family! If you watch my weekly vlogs you would have seen it enough!</font></div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"https://girlscangrill.com/wp-content/uploads/2022/08/ninja-grilled-chicken-breasts-500x500.jpg\" alt=\"Ninja Grilled Chicken Breasts - Girls Can Grill\" style=\"cursor: default;\"><font face=\"Arial\"><br><b style=\"\"><span style=\"font-size: x-large;\">INGREDIENTS</span></b><br>5 Chicken quarters<br>1 Red Onion<br>1 teaspoon Cameroon Pepper<br>4 tablespoons Suya Spice<br>2 teaspoons Salt<br>1 teaspoon crushed Ginger<br>2 Seasoning cubes<br>1 tablespoon Thyme<br>1 tablespoon Curry<br>3 Green Chillis<br>3 tablespoons Olive Oil<br></font><div class=\"separator\" style=\"margin: 0px; padding: 0px; clear: both; text-align: center;\"><br></div><font face=\"Arial\">PREPARATION<br></font><ul style=\"margin: 0.5em 0px; padding: 0px 2.5em; list-style: initial; line-height: 1.4;\"><li style=\"margin: 0px 0px 0.25em; padding: 0px; list-style: disc !important;\"><font face=\"Arial\">Preheat oven to 400 degrees-I just leave my top grill on at the highest setting since my cooker does not have numbers on the oven.&nbsp;</font></li></ul><ul style=\"margin: 0.5em 0px; padding: 0px 2.5em; list-style: initial; line-height: 1.4;\"><li style=\"margin: 0px 0px 0.25em; padding: 0px; list-style: disc !important;\"><font face=\"Arial\">In a blender/procerssor, blend all the ingredients together, except the chicken :)</font></li></ul><ul style=\"margin: 0.5em 0px; padding: 0px 2.5em; list-style: initial; line-height: 1.4;\"><li style=\"margin: 0px 0px 0.25em; padding: 0px; list-style: disc !important;\"><font face=\"Arial\">Wash and dab the chicken &nbsp;dry with a kitchen towel or just leave to drain.</font></li></ul><ul style=\"margin: 0.5em 0px; padding: 0px 2.5em; list-style: initial; line-height: 1.4;\"><li style=\"margin: 0px 0px 0.25em; padding: 0px; list-style: disc !important;\"><font face=\"Arial\">Add the blended marinede into a big bowl and add the chicken, rub it all over the chicken.You can place the chicken in the fridge to marinate for 30 minutes, overnight or cook immediately. I made mine immediately and it was still flavourful.</font></li></ul><ul style=\"margin: 0.5em 0px; padding: 0px 2.5em; list-style: initial; line-height: 1.4;\"><li style=\"margin: 0px 0px 0.25em; padding: 0px; list-style: disc !important;\"><font face=\"Arial\">Place the marinated chicken in a baking tray, skin side down first and place in the middle rack of the oven for 15 minutes, keep checking the chicken to make sure it does not burn.&nbsp;</font></li></ul><ul style=\"margin: 0.5em 0px; padding: 0px 2.5em; list-style: initial; line-height: 1.4;\"><li style=\"margin: 0px 0px 0.25em; padding: 0px; list-style: disc !important;\"><font face=\"Arial\">At the 15 minute mark, I reduce the heat and flip the chicken. I also use a cooking brush to apply a bit of olive oil and suya pepper on each side of the chicken, this is just to intensify the flavour.&nbsp;</font></li></ul><ul style=\"margin: 0.5em 0px; padding: 0px 2.5em; list-style: initial; line-height: 1.4;\"><li style=\"margin: 0px 0px 0.25em; padding: 0px; list-style: disc !important;\"><font face=\"Arial\">Check the chicken every 15 minutes and flip, cook for a total of 40 minutes.&nbsp;</font></li></ul><ul style=\"margin: 0.5em 0px; padding: 0px 2.5em; list-style: initial; line-height: 1.4;\"><li style=\"margin: 0px 0px 0.25em; padding: 0px; list-style: disc !important;\"><font face=\"Arial\">This chicken is enjoyed best when you eat it immediately because the skin will be crispy and inside moist!</font></li></ul><div style=\"margin: 0px; padding: 0px; text-align: justify;\"><font face=\"Arial\">Yum!</font></div></div></div></div></div></div>', '2024-03-25 09:30:51', NULL, 'T1ZFTiBHUklMTEVEIENISUNLRU4=', 'OVEN GRILLED CHICKEN', 0, b'0'),
(455, '<div><div>Rather than sharing a specific menu, we would like to give information about the most preferred American dishes for dinner;</div><div><span style=\"box-sizing: inherit; font-weight: 700;\">1. Pizza:</span>&nbsp;Any kind you like!&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">Cheese</span>,&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">pepperoni</span>,&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">vegetarian</span>,&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">chicken</span>,&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">pineapple</span>, etc. Within the years, variations have been created like thin dough,&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">parmesan crust</span>, double cheese layers, etc.</div><div><span style=\"box-sizing: inherit; font-weight: 700;\">2. Hamburger</span>:&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">Classic</span>&nbsp;or&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">cheeseburger</span>. Both are popular and much preferred. It is eaten with&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">french fries</span>&nbsp;on the side and coke as a drink. Also,&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">vegetarian hamburgers</span>&nbsp;are much demanded, especially for the last years.</div><div><span style=\"box-sizing: inherit; font-weight: 700;\">3. Steak:</span>&nbsp;Fillet, t-bone, rib, etc. One of the best option nutritionwise. You may even reach most of your daily protein intake with a portion of steak.&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">Barbequed meats</span>&nbsp;are inevitable for American people.</div><div><span style=\"box-sizing: inherit; font-weight: 700;\">4. Macaroni &amp; cheese:</span>&nbsp;Usually consumed as a side dish with&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">meat</span>&nbsp;but also consumed as a&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">main course</span>. The cheese type is the key point of this dish.</div><div><span style=\"box-sizing: inherit; font-weight: 700;\">5. Fajita:</span>&nbsp;The&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">meat</span>&nbsp;or&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">chicken</span>&nbsp;is cooked with onions and sweet green &amp; red peppers. On the side,&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">corn</span>&nbsp;or&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">flour tortilla</span>,&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">guacamole</span>,&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">sour cream</span>, and&nbsp;<span style=\"box-sizing: inherit; font-weight: 700;\">salsa sauce</span>&nbsp;are served.</div><div><span style=\"box-sizing: inherit; font-weight: 700;\">6. Buffalo wings:</span>&nbsp;Hot wings! Generally eaten along with a bottle of beer. The sauce is very demanding. Even though it is eaten by hands, it is favoured anytime.</div><div><div style=\"text-align: left;\"><span style=\"text-align: var(--bs-body-text-align); box-sizing: inherit; font-weight: 700;\">7. Fish:</span><span style=\"text-align: var(--bs-body-text-align);\">&nbsp;Most Americans prefer to have&nbsp;</span><span style=\"text-align: var(--bs-body-text-align); box-sizing: inherit; font-weight: 700;\">codfish</span><span style=\"text-align: var(--bs-body-text-align);\">&nbsp;or&nbsp;</span><span style=\"text-align: var(--bs-body-text-align); box-sizing: inherit; font-weight: 700;\">salmon</span><span style=\"text-align: var(--bs-body-text-align);\">&nbsp;at&nbsp;</span><span style=\"text-align: var(--bs-body-text-align); box-sizing: inherit; font-weight: 700;\">dinner time</span><span style=\"text-align: var(--bs-body-text-align);\">. Also, these kind are the most found and eaten ones in general.&nbsp;</span><span style=\"text-align: var(--bs-body-text-align); box-sizing: inherit; font-weight: 700;\">Mashed potatoes</span><span style=\"text-align: var(--bs-body-text-align);\">,&nbsp;</span><span style=\"text-align: var(--bs-body-text-align); box-sizing: inherit; font-weight: 700;\">cube-shaped potato salad</span><span style=\"text-align: var(--bs-body-text-align);\">,&nbsp;</span><span style=\"text-align: var(--bs-body-text-align); box-sizing: inherit; font-weight: 700;\">green leaves</span><span style=\"text-align: var(--bs-body-text-align);\">&nbsp;or&nbsp;</span><span style=\"text-align: var(--bs-body-text-align); box-sizing: inherit; font-weight: 700;\">biscuits</span><span style=\"text-align: var(--bs-body-text-align);\">&nbsp;might be served when dining outside.</span></div><div style=\"text-align: left;\"><span style=\"text-align: var(--bs-body-text-align);\"><br></span></div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"https://images.ctfassets.net/u128j5s4q9gv/mCskLRBrONw60RjZPTfLJ/3c8afe87dd4c1418fad72cb5ab76b212/hVsLkCVqTgqvhrJssDqfrhsHYgfxCJd09AYbMfWKyeGtClJ_BwAaAGSG-3HgH9iSph_7k7ltFLyKZdHtx7YN9SeT3WjN8xmXnpLgzCNrou5IIgj6eslSA7Au\" alt=\"hVsLkCVqTgqvhrJssDqfrhsHYgfxCJd09AYbMfWKyeGtClJ BwAaAGSG-3HgH9iSph 7k7ltFLyKZdHtx7YN9SeT3WjN8xmXnpLgzCNrou5IIgj6eslSA7Au\" style=\"cursor: default;\"><br></div></div>', '2024-03-25 09:31:39', NULL, 'V2VzdGVybiBmb29kIGZvciBsdW5jaCBhbmQgZGlubmVy', 'Western food for lunch and dinner', 0, b'0');
INSERT INTO `posts` (`id`, `content`, `create_at`, `created_actor`, `image`, `title`, `user_seen`, `archived`) VALUES
(456, '<header class=\"entry-header\" style=\"color: rgb(48, 42, 44); font-family: &quot;Libre Baskerville&quot;, Georgia, serif; letter-spacing: 0.26px;\"><h1 class=\"entry-title\" style=\"font-size: 18px; margin: 10px 0px 15px; font-family: Lato, Helvetica, sans-serif; letter-spacing: 3px; padding: 0px; text-transform: uppercase; text-align: center; color: rgb(48, 42, 44);\"><br></h1></header><div class=\"entry-content\" style=\"counter-reset: footnotes 0; color: rgb(48, 42, 44); letter-spacing: 0.26px;\"><div style=\"\"><em style=\"\"><font face=\"Arial\">This post documents the second half of the Wine Scholar Guild trip to Northern Spain. See the post&nbsp;<a href=\"http://wineandfoodpairings.net/spanish-whites/the-tapas-wine-of-northern-spain/\" target=\"_blank\" rel=\"noreferrer noopener\" style=\"background-color: transparent; transition-duration: 0.1s; transition-timing-function: ease-in-out; transition-property: all; color: rgb(30, 115, 190);\">The Tapas Wines of Spain</a>&nbsp;for the first half of the trip.</font></em></div><div style=\"\"><font face=\"Arial\">Leaving the Txakoli regions of northern Spain, our group headed south (about 2 hours by motorbus) to Rioja and its three subregions:&nbsp; Alta, Alavara and Orientali. On the timeline of European wine regions,&nbsp;<span style=\"font-weight: 600;\">Rioja was a latecomer.</span>&nbsp;The Greeks and Phoenicians never stepped foot there. And any vineyards cultivated by the colonizing Romans were put to rest by the centuries-long domination of the Muslims. In short,&nbsp;<span style=\"font-weight: 600;\">Rioja wine history starts in the Middle Ages</span>&nbsp;(10<span style=\"font-size: 9.75px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em;\">th</span>&nbsp;or 11<span style=\"font-size: 9.75px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em;\">th</span>&nbsp;century) with the advance of Christian Castilians.</font></div><figure class=\"wp-block-image size-full is-resized\" style=\"margin: 1em 40px;\"><a href=\"http://wineandfoodpairings.net/wp-content/uploads/2023/05/Rioja-Map.jpg\" data-featherlight=\"image\" style=\"background-color: transparent; transition-duration: 0.1s; transition-timing-function: ease-in-out; transition-property: all; color: rgb(30, 115, 190);\"><font face=\"Arial\"><img decoding=\"async\" src=\"http://wineandfoodpairings.net/wp-content/uploads/2023/05/Rioja-Map.jpg\" alt=\"\" class=\"wp-image-3068\" width=\"641\" height=\"641\" srcset=\"https://wineandfoodpairings.net/wp-content/uploads/2023/05/Rioja-Map.jpg 630w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Rioja-Map-300x300.jpg 300w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Rioja-Map-150x150.jpg 150w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Rioja-Map-320x320.jpg 320w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Rioja-Map-250x250.jpg 250w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Rioja-Map-40x40.jpg 40w\" sizes=\"(max-width: 641px) 100vw, 641px\" style=\"border: 0px; max-width: 100%; height: auto; margin-bottom: 20px; vertical-align: bottom; cursor: zoom-in;\"></font></a></figure><figure class=\"wp-block-image size-large\" style=\"margin: 1em 40px;\"><a href=\"http://wineandfoodpairings.net/wp-content/uploads/2023/05/San-Vicente-1.jpg\" data-featherlight=\"image\" style=\"background-color: transparent; transition-duration: 0.1s; transition-timing-function: ease-in-out; transition-property: all; color: rgb(30, 115, 190);\"><font face=\"Arial\"><img decoding=\"async\" width=\"1024\" height=\"768\" src=\"http://wineandfoodpairings.net/wp-content/uploads/2023/05/San-Vicente-1-1024x768.jpg\" alt=\"\" class=\"wp-image-3067\" srcset=\"https://wineandfoodpairings.net/wp-content/uploads/2023/05/San-Vicente-1-1024x768.jpg 1024w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/San-Vicente-1-300x225.jpg 300w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/San-Vicente-1-768x576.jpg 768w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/San-Vicente-1-1536x1152.jpg 1536w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/San-Vicente-1-800x600.jpg 800w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/San-Vicente-1-1200x900.jpg 1200w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/San-Vicente-1.jpg 2016w\" sizes=\"(max-width: 1024px) 100vw, 1024px\" style=\"border: 0px; max-width: 100%; height: auto; margin-bottom: 20px; vertical-align: bottom; cursor: zoom-in;\"></font></a><figcaption class=\"wp-element-caption\" style=\"margin-bottom: 1em; margin-top: 0.5em;\"><span style=\"font-weight: 600;\"><font face=\"Arial\">Tempranillo Bush Vines with San Vicente in the background</font></span></figcaption></figure><div style=\"\"><font face=\"Arial\">During the next 4 days, we toured, tasted and queried&nbsp;<span style=\"font-weight: 600;\">10 different producers of Rioja wine</span>. Documenting each visit in this blog post would be unwieldy and fatiguing to read, so I opted to share with you my&nbsp;<span style=\"font-weight: 600;\">favorite wines of the trip,</span>&nbsp;<span style=\"font-weight: 600;\">with the qualification that they must be available in the US</span>. There were other favorites, but sadly, not sold in the States.</font></div><div style=\"\"><span style=\"font-weight: 600;\"><font face=\"Arial\">White Rioja</font></span></div><div style=\"\"><font face=\"Arial\">Rioja Blanco, as it’s called, is made from the&nbsp;<span style=\"font-weight: 600;\">Viura grape</span>&nbsp;(also known as Macabeo), with some winemakers choosing to add small amounts of juice from Malvasia. I found most of these offerings uninspiring when compared to white wines from other Spanish regions or other countries (France, Germany and Italy). That said, I was duly impressed with the Blanco Gran Reserva 2016 from&nbsp;<span style=\"font-weight: 600;\">Remírez de Ganuza</span>&nbsp;($114), as well as their&nbsp;<span style=\"font-weight: 600;\">Blanco Reserva 2020&nbsp;</span>($42) (two bottles on the far right in the photo below).</font></div><figure class=\"wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-1 is-layout-flex wp-block-gallery-is-layout-flex\" style=\"margin: 1em 40px; gap: var( --wp--style--gallery-gap-default, var( --gallery-block--gutter-size, var( --wp--style--block-gap, 0.5em ) ) ); display: flex; flex-wrap: wrap; align-items: normal; --wp--style--unstable-gallery-gap: var( --wp--style--gallery-gap-default, var( --gallery-block--gutter-size, var( --wp--style--block-gap, 0.5em ) ) );\"><figure class=\"wp-block-image size-large\" style=\"margin-bottom: 0px; display: flex; flex-direction: column; flex-grow: 1; justify-content: center; max-width: 100%; position: relative; width: calc(50% - var(--wp--style--unstable-gallery-gap, 16px)*.5); align-self: inherit;\"><a href=\"http://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-1.jpg\" data-featherlight=\"image\" style=\"background-color: transparent; transition-duration: 0.1s; transition-timing-function: ease-in-out; transition-property: all; color: rgb(30, 115, 190); flex-direction: column; flex: 1 0 0%; margin: 0px; display: flex; height: 268.555px; object-fit: cover; width: 296.75px;\"><img loading=\"lazy\" decoding=\"async\" width=\"1024\" height=\"768\" data-id=\"3066\" src=\"http://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-1-1024x768.jpg\" alt=\"\" class=\"wp-image-3066\" srcset=\"https://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-1-1024x768.jpg 1024w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-1-300x225.jpg 300w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-1-768x576.jpg 768w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-1-1536x1152.jpg 1536w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-1-800x600.jpg 800w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-1-1200x900.jpg 1200w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-1.jpg 2016w\" sizes=\"(max-width: 1024px) 100vw, 1024px\" style=\"border: 0px; max-width: 100%; height: 248.555px; margin-bottom: 20px; vertical-align: bottom; cursor: zoom-in; display: block; width: 296.75px; flex: 1 0 0%; object-fit: cover;\"></a></figure><figure class=\"wp-block-image size-large\" style=\"margin-bottom: 0px; display: flex; flex-direction: column; flex-grow: 1; justify-content: center; max-width: 100%; position: relative; width: calc(50% - var(--wp--style--unstable-gallery-gap, 16px)*.5); align-self: inherit;\"><a href=\"http://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-Blanco-Reserva-2020.jpg\" data-featherlight=\"image\" style=\"background-color: transparent; transition-duration: 0.1s; transition-timing-function: ease-in-out; transition-property: all; color: rgb(30, 115, 190); flex-direction: column; flex: 1 0 0%; margin: 0px; display: flex; height: 268.555px; object-fit: cover; width: 296.75px;\"><img loading=\"lazy\" decoding=\"async\" width=\"782\" height=\"655\" data-id=\"3065\" src=\"http://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-Blanco-Reserva-2020.jpg\" alt=\"\" class=\"wp-image-3065\" srcset=\"https://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-Blanco-Reserva-2020.jpg 782w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-Blanco-Reserva-2020-300x251.jpg 300w, https://wineandfoodpairings.net/wp-content/uploads/2023/05/Ganuza-Blanco-Reserva-2020-768x643.jpg 768w\" sizes=\"(max-width: 782px) 100vw, 782px\" style=\"border: 0px; max-width: 100%; height: 248.555px; margin-bottom: 20px; vertical-align: bottom; cursor: zoom-in; display: block; width: 296.75px; flex: 1 0 0%; object-fit: cover;\"></a></figure></figure><div style=\"\"><font face=\"Arial\">Made from 80% viura and 20% Malvasia &amp; Garnacha Blanca, the wines are buttery and complex, more so with the Gran Reserva. Pair these wines with your best roasted chicken or roast pork recipes.</font></div></div>', '2024-03-25 09:31:21', NULL, 'VEhFIFdJTkVTIE9GIFJJT0pB', 'THE WINES OF RIOJA', 0, b'0'),
(552, '<font face=\"Arial\"><div class=\"article-metadata \" style=\"margin-bottom: 15px; display: inline-block; width: 715.328px; font-size: 18px;\"><h1 class=\"article-title\" style=\"font-size: 36px; margin: 10px 0px; line-height: 1.1;\"><span style=\"font-size:16px;\">Tropical Smoothie Cafe opens location near Penn\'s campus at 3737 Chestnut apartment building</span></h1><div class=\"share-btns affix\" data-spy=\"affix\" style=\"position: fixed; margin-left: -50px; text-align: center; top: 80px;\"><a class=\"sharer\" data-sharer=\"facebook\" data-title=\"Via @dailypenn\" data-url=\"http://www.thedp.com/article/2023/11/penn-new-restaurant-tropical-smoothie-cafe-opens-university-city\" style=\"background-color: transparent; color: rgb(0, 0, 0); cursor: pointer;\"><svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\" viewBox=\"0 0 24 24\" fill=\"#3B5998\"><path d=\"M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z\"></path></svg></a><br><a class=\"sharer fa fa-lg fa-twitter\" data-sharer=\"twitter\" data-title=\"Via @dailypenn\" data-url=\"http://www.thedp.com/article/2023/11/penn-new-restaurant-tropical-smoothie-cafe-opens-university-city\" style=\"background-color: transparent; color: rgb(170, 30, 34); outline: 0px; cursor: pointer;\"><svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\" viewBox=\"0 0 24 24\" fill=\"#1DA1F2\"><path d=\"M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z\"></path></svg></a></div><br></div><span style=\"font-size: 18px;\"></span></font><figure class=\"dominant-media\" style=\"margin-bottom: 0px; font-size: 18px;\"><a href=\"https://www.thedp.com/multimedia/e8209801-f7c8-454a-b9b2-df57296708e7\" style=\"background-color: transparent; color: rgb(170, 30, 34);\"><font face=\"Arial\"><img class=\"img img-responsive img-fill\" src=\"https://snworksceo.imgix.net/dpn/2c1f5714-6c79-4545-abdf-8405308e93aa.sized-1000x1000.jpg?w=1000\" alt=\"11-06-23-tropical-smoothie-cafe-01-jean-park\" style=\"border: 0px; max-width: 100%; display: block; height: auto; min-width: 100%;\"></font></a><figcaption style=\"font-size: 0.8rem; font-style: italic; color: rgb(85, 85, 85); padding-bottom: 15px; line-height: 1rem; margin-top: 0.5rem;\"><div style=\"text-align: center; \"><font face=\"Arial\">A new Tropical Smoothie Cafe location recently opened at 37th and Chestnut street on Oct. 25.</font></div><font face=\"Arial\">Credit:&nbsp;<a href=\"https://www.thedp.com/staff/jean-park\" style=\"background-color: transparent; color: rgb(170, 30, 34);\">Jean Park</a></font></figcaption></figure><div style=\"text-align: justify; \"><font face=\"Arial\"><a href=\"https://www.tropicalsmoothiecafe.com/\" target=\"_blank\" style=\"background-color: transparent; color: rgb(170, 30, 34);\">Tropical Smoothie Cafe</a>&nbsp;opened its first University City location on Oct. 25 in the ground floor of apartment building 3737 Chestnut.</font></div><div style=\"text-align: justify; \"><font face=\"Arial\">Tropical Smoothie Cafe, located at 37th and Chestnut street, is a national fast-casual food and beverage chain specializing in smoothies and health foods. The University City location is the chain\'s third in Philadelphia. The store opened its first location in Florida in 1993 and currently operates over 1,000 stores in the United States.</font></div><div style=\"text-align: justify; \"><font face=\"Arial\">Paul Patel, a Tropical Smoothie Cafe staff member, said he is proud of the cafe’s commitment to health-conscious dining. He emphasized the cafe’s use of healthier alternative ingredients than what customers might typically expect, noting that the chain uses turbinado instead of regular sugar in its smoothies.</font></div><div style=\"text-align: justify; \"><font face=\"Arial\">“Whatever we are selling is healthy,” he said.</font></div><div class=\"info-box hidden-sm hidden-xs\" style=\"position: relative; float: left; left: -25px; width: 200px; margin-bottom: 5px; padding-top: 10px; border-top: 5px solid rgb(0, 0, 0); border-bottom: 5px solid rgb(0, 0, 0); font-size: 14px; line-height: 1.5;\"><div style=\"text-align: justify; \"><span style=\"font-weight: 700;\"><font face=\"Arial\">RELATED:﻿</font></span></div><div style=\"text-align: justify; \"><a href=\"https://dpn.ceo.getsnworks.com/ceo/locate/857b6705-b5d7-4331-ad87-a4b16f3d442d\" style=\"background-color: transparent; color: rgb(170, 30, 34);\"><font face=\"Arial\">New fried chicken restaurant opens in University City for \'hangry\' college students</font></a></div><div style=\"text-align: justify; \"><a href=\"https://dpn.ceo.getsnworks.com/ceo/locate/af3e235a-0657-4c9d-9d8c-ca8b0262e86c\" style=\"background-color: transparent; color: rgb(170, 30, 34);\"><font face=\"Arial\">From Lyn\'s to Hemo\'s, the DP mapped Penn\'s food truck scene</font></a></div></div><div style=\"text-align: justify; \"><font face=\"Arial\">Patel highlighted the cafe\'s best-selling products: Bahama Mama, a smoothie made up of strawberries, pineapple, coconut, and white chocolate, and Sunrise Sunset, made up of strawberries, pineapple, mango &amp; orange juice. Other than smoothies, the cafe\'s menu includes sandwiches, salads, wraps, and quesadillas.&nbsp;</font></div><figure class=\"embedded-media\" style=\"margin-bottom: 0px; font-size: 18px; max-width: 100%; width: 944.766px;\"><img src=\"https://snworksceo.imgix.net/dpn/502510ec-c5e3-4453-aa14-8d68020acec4.sized-1000x1000.jpg?w=1000\" class=\"img img-responsive embedded-img\" style=\"border: 0px; max-width: 100%; display: block; height: auto; margin: auto;\"><figcaption class=\"embedded-caption text-muted\" style=\"font-size: 15px; font-style: italic; color: rgb(119, 119, 119); padding-bottom: 15px; line-height: 1.5;\"><small style=\"font-size: 12.75px;\"><font face=\"Arial\">Credit:&nbsp;<a href=\"https://www.thedp.com/staff/jean-park\" style=\"background-color: transparent; color: rgb(170, 30, 34);\">Jean Park</a><div>Tropical Smoothie Cafe offers smoothies and health foods, like salad, wraps, and flatbread.</div></font></small></figcaption></figure><div style=\"text-align: justify; \"><font face=\"Arial\">Patel said that people should not mistake the cafe for only serving smoothies because of its name.&nbsp;</font></div><div style=\"text-align: justify; \"><font face=\"Arial\">“We have salad, wraps, and flatbread too,\" he said. \"The important thing is we are not about just smoothies.\"</font></div><div style=\"text-align: justify; \"><font face=\"Arial\">Graduate School of Education graduate student Ceani Beaden said that she had visited Tropical Smoothie Cafe three days in a row and appreciated that the food options are not too heavy.</font></div><div style=\"text-align: justify; \"><font face=\"Arial\"><span style=\"font-size:16px;\">\"If I go to a food truck, I might not like it. But I always get the same experience here,\" she said.</span></font></div>', '2024-03-25 10:22:51', NULL, 'U21vb3RoaWU=', 'Smoothie', 0, b'0'),
(802, '<div><div class=\"post-header\" style=\"list-style: none; margin: 0px 0px 30px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline;\"><h1 class=\"post-title entry-title\" itemprop=\"headline\" style=\"text-align: justify; list-style: none; margin: 8px 0px 2px; padding: 0px; overflow-wrap: break-word; position: relative; border: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-variant-position: normal; font-stretch: normal; font-size: 18px; line-height: normal; font-family: &quot;Crimson Text&quot;, serif; vertical-align: baseline; color: rgb(0, 0, 0); text-transform: uppercase;\">EATIGO\'S “WOW WEDNESDAY IS OFFERING DINE OUT WITH 50% OFF ALL DAY THIS APRIL 18!</h1><span class=\"post-location\" style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-alternates: normal; font-kerning: auto; font-optical-sizing: auto; font-feature-settings: normal; font-variation-settings: normal; font-variant-position: normal; font-stretch: normal; font-size: 12px; line-height: normal; font-family: &quot;Crimson Text&quot;, serif; vertical-align: baseline; display: block; text-align: center; letter-spacing: 2px; text-transform: capitalize;\"></span></div><div class=\"post-body entry-content\" id=\"post-body-5855511662643189003\" itemprop=\"articleBody\" style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: 15.4px; line-height: 1.4; font-family: inherit; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline; width: 632px; overflow: hidden; text-align: justify; color: rgb(0, 0, 0);\"><div class=\"separator\" style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; clear: both;\"><a href=\"https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj34BmKb5snv6cY0i_sBMfaN01BuT2961a1mgsp7oJfBWtgTH8BnVKrbBH5ptsR_oFIDhEUv6Pl5AYxuopnx3MJM1GeHBkSbbuULXF4_vkY48Q8NdvJzwki3PrvzVtHHyZ2QydIw-Pv8hHZ/s1600/EATIGO+PROMO+CODES+PHILIPPINES.png\" imageanchor=\"1\" style=\"list-style: none; margin: 0px 1em; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; max-width: calc(800px); height: auto; color: rgb(53, 53, 53);\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><img border=\"0\" data-original-height=\"640\" data-original-width=\"640\" src=\"https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj34BmKb5snv6cY0i_sBMfaN01BuT2961a1mgsp7oJfBWtgTH8BnVKrbBH5ptsR_oFIDhEUv6Pl5AYxuopnx3MJM1GeHBkSbbuULXF4_vkY48Q8NdvJzwki3PrvzVtHHyZ2QydIw-Pv8hHZ/s1600/EATIGO+PROMO+CODES+PHILIPPINES.png\" style=\"list-style: none; margin: 0px; padding: 0px; outline: none; overflow-wrap: break-word; border: 0px none; font: inherit; vertical-align: baseline; max-width: 100%; height: auto; display: inline; width: 632px; position: static !important; float: none !important;\"></span></a></div><br style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word;\"><a name=\"more\" style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; max-width: calc(800px);\"></a><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"></span><br style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word;\"><div style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">Looking for promo codes that offer discounts to your most favorite restaurants in Manila?Check out&nbsp; Eatigo, a revolutionary dining app that lets you eat sumptuous, mouthwatering dishes at half the price ALL DAY. Yes, you heard it right! Dubbed as WOW Wednesday, starting this summer, Eatigo is offering 50% off at your favorite restaurants every Wednesday of each month.</span><br style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><br style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word;\"></span><br style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word;\"><div class=\"separator\" style=\"text-align: justify; list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; clear: both;\"><a href=\"https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjHrkRXsQJDY_gROG91lTqNxEssrZjpqBt2GgOqWDSgqYnU-Efann1s-SnMsjlsV8mKLLhp9_n36_EGZwS6fNsxmJrcwHJnPNN1SYjAPbIoH2qd7lIl1qBWt-LF5Xl29_C-iTh0dEkH9WKo/s1600/eatigo+philippines+app+review.png\" imageanchor=\"1\" style=\"list-style: none; margin: 0px 1em; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; max-width: calc(800px); height: auto; color: rgb(53, 53, 53);\"><img alt=\"eatigo philippines app review\" border=\"0\" data-original-height=\"378\" data-original-width=\"911\" src=\"https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjHrkRXsQJDY_gROG91lTqNxEssrZjpqBt2GgOqWDSgqYnU-Efann1s-SnMsjlsV8mKLLhp9_n36_EGZwS6fNsxmJrcwHJnPNN1SYjAPbIoH2qd7lIl1qBWt-LF5Xl29_C-iTh0dEkH9WKo/s1600/eatigo+philippines+app+review.png\" title=\"eatigo philippines app review\" style=\"list-style: none; margin: 0px; padding: 0px; outline: none; overflow-wrap: break-word; border: 0px none; font: inherit; vertical-align: baseline; max-width: 100%; height: auto; display: inline; width: 632px; position: static !important; float: none !important;\"></a></div><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><div style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; line-height: inherit; font-family: &quot;Crimson Text&quot;, serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: large; line-height: inherit; font-family: inherit; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><b style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">List of r</b><b style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">estaurants</b></span>&nbsp;</span></div><div style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; line-height: inherit; font-family: &quot;Crimson Text&quot;, serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">Eatigo partnered with a variety of restaurants to make sure that whatever your taste\'s desire, they got it for you! Here they are:</span></div><ul style=\"list-style: initial; margin: 0.5em 0px; padding: 0px 2.5em; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; line-height: 1.4; font-family: &quot;Crimson Text&quot;, serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><li style=\"margin: 0px 0px 0.25em; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; list-style: disc !important;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">Barcino - the home of authentic Spanish cuisines</span></li><li style=\"margin: 0px 0px 0.25em; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; list-style: disc !important;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">Dillingers 1903 - where steaks and pasta reign supreme</span></li><li style=\"margin: 0px 0px 0.25em; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; list-style: disc !important;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">&nbsp;Alta at Ascott BGC - an American and Italian restaurant helmed by world-famous Chef Margarita Fores</span></li><li style=\"margin: 0px 0px 0.25em; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; list-style: disc !important;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">Gelatofix - a lifestyle café specializing on a spectrum of dishes that complement their vast gelato flavors</span></li><li style=\"margin: 0px 0px 0.25em; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; list-style: disc !important;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">Vengo - where you can find the marriage of a taqueria and coffee shop in one shop. The impressive list of brands goes on! Check it out on the dedicated WOW Wednesday panel on the Eatigo app.</span></li></ul><br style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; font-family: &quot;Crimson Text&quot;, serif;\"><div style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; line-height: inherit; font-family: &quot;Crimson Text&quot;, serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">I think this is good news for all those who are on a tight budget. I mean, 50% discount is huge already!&nbsp; It will officially start on April 18 but seats can be reserved as early as 12 midnight of April 16!</span></div><div style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; line-height: inherit; font-family: &quot;Crimson Text&quot;, serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><br style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word;\"></span></div><div style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; line-height: inherit; font-family: &quot;Crimson Text&quot;, serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">All you need to&nbsp;do is&nbsp; download the Eatigo App now&nbsp;<a href=\"http://bit.ly/2HtdlH8\" rel=\"nofollow\" target=\"_blank\" style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font: inherit; vertical-align: baseline; color: rgb(53, 53, 53); max-width: calc(800px);\">http://bit.ly/2HtdlH8</a>. Then you can start</span></div><div style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; line-height: inherit; font-family: &quot;Crimson Text&quot;, serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">choosing which one from these official restaurant partners of Eatigo.&nbsp; The next best thing is to like&nbsp;Eatigo’s Facebook page to keep updated with the next schedules of WOW Wednesday!</span></div><div style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; line-height: inherit; font-family: &quot;Crimson Text&quot;, serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><br style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word;\"></span></div><div style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; line-height: inherit; font-family: &quot;Crimson Text&quot;, serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: large; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><b style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">About Eatigo</b></span></div><div style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-variant-alternates: inherit; font-variant-position: inherit; font-stretch: inherit; line-height: inherit; font-family: &quot;Crimson Text&quot;, serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\"><span style=\"list-style: none; margin: 0px; padding: 0px; outline: 0px; overflow-wrap: break-word; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: arial, helvetica, sans-serif; font-optical-sizing: inherit; font-kerning: inherit; font-feature-settings: inherit; font-variation-settings: inherit; vertical-align: baseline;\">Eatigo was founded in 2013.&nbsp; It\'s&nbsp;mission is to connect empty tables with empty stomachs by offering time-based discounts of up to 50% every day at all of its participating restaurants through its online website and mobile applications. Having seated over 5 million diners at more than 2,000 venues across the region, eatigo is the leading online reservations platform for restaurants in Asia, downloaded by more than 1.5 million users. Backed by TripAdvisor with total up to date funding of US$15.5 million, eatigo is available in Thailand, Singapore, Malaysia, Hong Kong, India &amp; Manila and is looking to expand to more countries. Users can choose to dine anywhere, from upscale hotels to popular food chains, and enjoy the same discounts with no strings attached, while restaurants get to fill their empty seats during off-peak hours.</span></div></span></div></div></div>', '2024-04-15 19:25:08', NULL, 'THVja3kgV2VkbmVzZGF5', 'Lucky Wednesday', 0, b'0');
INSERT INTO `posts` (`id`, `content`, `create_at`, `created_actor`, `image`, `title`, `user_seen`, `archived`) VALUES
(803, '<div><header class=\"entry-header\" style=\"color: rgb(64, 64, 64); font-family: &quot;Playfair Display&quot;, Georgia, Cambria, &quot;Times New Roman&quot;, Times, serif; font-size: 16px;\"><h1 class=\"entry-title\" style=\"overflow-wrap: break-word; font-size: 52px; margin: 0.67em 0px -25px; clear: both; line-height: 55px; font-family: Chelsea-IV; letter-spacing: 1px;\">$200 Restaurant Voucher Up for Grabs!</h1></header><div class=\"entry-content\" style=\"margin: 1.5em 0px 0px; color: rgb(64, 64, 64); font-family: &quot;Playfair Display&quot;, Georgia, Cambria, &quot;Times New Roman&quot;, Times, serif; font-size: 16px;\"><div><img class=\"alignnone size-full wp-image-1164\" src=\"https://armanirestaurant.com.au/wp-content/uploads/2018/07/AR-200-voucher-giveaway-blog.jpg\" alt=\"\" width=\"1000\" height=\"533\" srcset=\"https://armanirestaurant.com.au/wp-content/uploads/2018/07/AR-200-voucher-giveaway-blog.jpg 1000w, https://armanirestaurant.com.au/wp-content/uploads/2018/07/AR-200-voucher-giveaway-blog-600x320.jpg 600w, https://armanirestaurant.com.au/wp-content/uploads/2018/07/AR-200-voucher-giveaway-blog-300x160.jpg 300w, https://armanirestaurant.com.au/wp-content/uploads/2018/07/AR-200-voucher-giveaway-blog-768x409.jpg 768w, https://armanirestaurant.com.au/wp-content/uploads/2018/07/AR-200-voucher-giveaway-blog-100x53.jpg 100w\" sizes=\"(max-width: 1000px) 100vw, 1000px\" style=\"height: auto; max-width: 100%; border: 0px;\"></div><div>At Venus Restaurant, we just love seeing our guests enjoy our amazing food and service. As a token of our gratitude, we’re giving away a restaurant voucher worth $200! All you have to do is post your photos or videos taken at Armani and tag us @armani_restaurant_sydney or #ArmaniRestaurant</div><div>Only public photos will be considered as entries to the draw. Giveaway runs from 1<span style=\"font-size: 12px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em;\">st</span>&nbsp;of July 2018. Winner will be announced every Monday fortnightly.</div><div>Restaurant vouchers are only valid for 1 month upon receipt and can only be used from Monday – Thursday. Winners MUST call beforehand to book. Prize can only be used by the winner and is non-exchangeable and non-transferable.</div><h3 style=\"overflow-wrap: break-word; clear: both; font-size: 35px; line-height: 38px; font-family: Chelsea-IV; letter-spacing: 1px;\">TERMS AND CONDITIONS</h3><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">PROMOTER</h4><ol style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">The Promoter is at 354 Church Street Parramatta NSW 2150 ([Telephone] (02) 8840 9453) (“Promoter”) Competition permit number:&nbsp;<a href=\"https://www.onegov.nsw.gov.au/GLS_Portal/snsw/Attachment.mvc/ViewCompletedApplication?ApplicationID=5863051\" style=\"background-color: transparent; color: rgb(206, 185, 121);\">APP-0004372789</a></li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">COMPETITON PERIOD</h4><ol start=\"2\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">The competition giveaway ends at digression of Armani Restaurant (“Competition Period”). All references to time are local in Sydney, Australia</li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">WHO MAY ENTER</h4><ol start=\"3\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">This competition is open to all Australian residents, over the age of 18, who follow outlined instructions.</li><li style=\"line-height: 1.2em; margin-bottom: 10px;\">This competition is not open to any employees or family members of Armani Restaurant or its related bodies.</li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">ENTRANTS BOUND BY CONDITIONS</h4><ol start=\"5\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">By participating, entrants agree to be bound by these Terms and Conditions.</li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">HOW TO ENTER</h4><ol start=\"6\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">To enter, entrants must read these Terms and Conditions, and follow all competition instructions</li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">LIMITATIONS ON ENTRY</h4><ol start=\"8\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">Each person following instructions will be counted as only one entry.</li><li style=\"line-height: 1.2em; margin-bottom: 10px;\">Entry into the competition is free. However, any costs associated with an individual entering the competition are the responsibility of the entrant.</li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">ENTRY VERIFICATION</h4><ol start=\"10\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">The Promoter reserves the right to verify the validity of entries and to disqualify any entrant who tampers with the entry process or who submits an entry that is not in accordance with these Terms and Conditions.</li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">SELECTION OF WINNERS</h4><ol start=\"11\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">The prize draw will take place at 354 Church Street Parramatta NSW 2150, New South Wales on the 21/08/2018 at 10:00 am AEST.</li><li style=\"line-height: 1.2em; margin-bottom: 10px;\">The winner will be chosen at digression of Armani Restaurant.</li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">PRIZES</h4><ol start=\"13\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">The Prize is one (1) $200 restaurant voucher to Armani Restaurant.</li><li style=\"line-height: 1.2em; margin-bottom: 10px;\">The Prize will be issued subject to the applicants’ meeting eligibility criteria and subject to the policy’s terms, conditions, limitations and exclusions.</li><li style=\"line-height: 1.2em; margin-bottom: 10px;\">Prizes are not transferable or exchangeable and cannot be redeemed for cash, this includes any unused portion of the prize.</li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">WINNER NOTIFICATION AND PUBLICATION</h4><ol start=\"16\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">The winner will be notified in writing via Facebook or email within two (2), for a minimum period of 28 days. The winner will also be notified via phone call. When the Promoter advises the winner they have won a prize, the particulars of how the prize is to be delivered is advised to the winner. The Promoter will not notify entrants of failure to win a Prize. The Promoter will make reasonable efforts to contact the Prize winner; however the Promoter is not responsible for contacting the winner by any other method, or for the winner not receiving notification for any reason. Entrants are responsible for providing and maintaining correct contact details. Each entrant warrants that any details provided with his/her entry are true and accurate, and the entrant indemnifies the Promoter against any loss or damage resulting from any breach of this warranty.</li><li style=\"line-height: 1.2em; margin-bottom: 10px;\">The Promoter is not responsible for any lost, late, incorrectly entered or misdirected entries.</li><li style=\"line-height: 1.2em; margin-bottom: 10px;\">The Promoter is not responsible for any problems, technical malfunction or failure of any telephone network or lines, computer online systems, servers, providers, computer equipment, software, email or other communication network or system, including any failure of an entry to be received in whole or in part by the Promoter due to any of the above or on account of other technical problems or traffic congestion on the internet or at any website or telecommunication systems, or any combination of these issues.</li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">CONSENT TO USE ENTRIES</h4><ol start=\"19\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">By entering the competition, entrants consent to the information they submit with their entry, including personal details and/or literary response, being entered into a database and the Promoter may use this information in any media for future promotional, marketing and publicity purposes (including sending electronic communication) without any further reference, payment or other compensation to the entrant.</li><li style=\"line-height: 1.2em; margin-bottom: 10px;\">All entries are the property of the Promoter.</li></ol><h4 style=\"overflow-wrap: break-word; clear: both; font-family: Chelsea-IV; letter-spacing: 1px;\">PRIVACY</h4><ol start=\"21\" style=\"overflow-wrap: break-word; margin: 0px 0px 1.5em; list-style-position: initial; list-style-image: initial;\"><li style=\"line-height: 1.2em; margin-bottom: 10px;\">Entrants’ personal information is collected, used, stored and disclosed in accordance with the Promoters Privacy Policy.</li></ol></div></div>', '2024-04-15 19:32:16', NULL, 'R2l2ZWF3YXk6ICQyMDAgVmVudWUgVm91Y2hlciE=', 'Giveaway: $200 Venue Voucher!', 0, b'0');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `posts_seq`
--

CREATE TABLE `posts_seq` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `posts_seq`
--

INSERT INTO `posts_seq` (`next_val`) VALUES
(51);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reservation`
--

CREATE TABLE `reservation` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `person_number` int(11) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `table_id` bigint(20) DEFAULT NULL,
  `end_time` varchar(255) DEFAULT NULL,
  `start_time` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `restaurant_table`
--

CREATE TABLE `restaurant_table` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `seat_count` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `table_number` varchar(255) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `online` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `restaurant_table`
--

INSERT INTO `restaurant_table` (`id`, `created_on`, `updated_on`, `version`, `seat_count`, `status`, `table_number`, `category_id`, `online`, `price`) VALUES
(1, NULL, NULL, 151, 6, 1, '1', 1, NULL, NULL),
(2, NULL, NULL, 47, 6, 1, '2', 2, NULL, NULL),
(3, NULL, NULL, 12, 2, 1, '3', 1, NULL, NULL),
(4, NULL, NULL, 9, 4, 1, '4', 2, NULL, NULL),
(5, NULL, NULL, 20, 4, 1, '5', 1, NULL, NULL),
(6, NULL, NULL, 3, 4, 1, '6', 2, NULL, NULL),
(7, NULL, NULL, 1, 6, 1, '7', 1, NULL, NULL),
(8, NULL, NULL, 8, 6, 1, '8', 1, NULL, NULL),
(9, NULL, NULL, 2, 6, 1, '9', 1, NULL, NULL),
(10, NULL, NULL, 0, 2, 1, '10', 1, NULL, NULL),
(11, NULL, NULL, 0, 4, 1, '11', 1, NULL, NULL),
(12, NULL, NULL, 2, 2, 1, '12', 1, NULL, NULL),
(13, NULL, NULL, 0, 8, 1, '22', 1, NULL, NULL),
(14, NULL, NULL, 0, 6, 1, '19', 1, NULL, NULL),
(16, NULL, NULL, 4, 8, 1, '23', 2, NULL, NULL),
(17, NULL, NULL, 0, 10, 1, 'D24', 2, NULL, NULL),
(18, NULL, NULL, 0, 10, 1, 'D25', 2, NULL, NULL),
(19, NULL, NULL, 0, 10, 1, 'D26', 2, NULL, NULL),
(20, NULL, NULL, 0, 10, 1, 'D27', 2, NULL, NULL),
(21, NULL, NULL, 0, 12, 1, 'D28', 2, NULL, NULL),
(22, NULL, NULL, 1, 15, 1, 'D29', 2, NULL, NULL),
(23, NULL, NULL, 0, 5, 1, 'D30', 1, NULL, NULL),
(24, NULL, NULL, 0, 5, 1, 'D31', 1, NULL, NULL),
(25, NULL, NULL, 0, 4, 1, 'D32', 1, NULL, NULL),
(26, NULL, NULL, 0, 4, 1, 'D33', 1, NULL, NULL),
(27, NULL, NULL, 0, 2, 1, '34', 1, NULL, NULL),
(28, NULL, NULL, 0, 2, 1, '35', 1, NULL, NULL),
(29, NULL, NULL, 0, 4, 1, '37', 1, NULL, NULL),
(30, NULL, NULL, 0, 2, 0, '99', 1, 1, 100),
(31, NULL, NULL, 0, 4, 1, '100', 1, 1, 100);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `restaurant_table_ingredients`
--

CREATE TABLE `restaurant_table_ingredients` (
  `restaurant_table_id` bigint(20) NOT NULL,
  `ingredients_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `description` varchar(150) NOT NULL,
  `name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `created_on`, `updated_on`, `version`, `description`, `name`) VALUES
(1, NULL, NULL, 0, 'ADMIN', 'ADMIN'),
(13, NULL, NULL, 0, '', 'CHEF'),
(19, NULL, NULL, 0, '', 'STAFF');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tables`
--

CREATE TABLE `tables` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `capacity` varchar(255) DEFAULT NULL,
  `name_table` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tables`
--

INSERT INTO `tables` (`id`, `created_on`, `updated_on`, `version`, `capacity`, `name_table`, `description`) VALUES
(1, '2024-04-15 09:12:27.000000', NULL, 0, '2', 'TABLE FOR A COUPLE', NULL),
(2, '2024-04-15 09:12:46.000000', NULL, 0, '3', 'TABLE FOR 3 PEOPLE', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `unit`
--

CREATE TABLE `unit` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `unit_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `change_password` tinyint(1) DEFAULT 1,
  `email` varchar(64) NOT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `password` varchar(128) NOT NULL,
  `photo` varchar(1024) DEFAULT NULL,
  `reset_password_token` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `created_on`, `updated_on`, `version`, `change_password`, `email`, `enabled`, `first_name`, `last_name`, `password`, `photo`, `reset_password_token`) VALUES
(1, NULL, NULL, 0, 0, 'admin2@abc.com', 1, 'Admin 2', 'Portal', '$2a$10$HZdmr.yzCHoVcbJwsmO9A.7RO1ieh22baygy3641OFyNYIegaqXw6', NULL, NULL),
(2, NULL, NULL, 1, 0, 'admin100@ymai.com', 0, 'Admin100', 'Portal', '$2a$10$7momcE5.MgSEzI.JD1TgAu6fUJowMWnBzkDO9lo/G76N7/SRLnmdS', NULL, 'Tms2bsG4ApK2hwriGt7TAjTXrGEU4fV8MTcxMDcyOTU5MTk5Mg=='),
(103, NULL, NULL, 0, 0, 'admin3@abc.com', 0, 'Admin 3', 'Portal', '$2a$10$f/woL/NxkIheC16Wthv0VO/cVpdnRn3v9Ngim5r/16r4b5i3fqN9K', NULL, NULL),
(154, NULL, NULL, 0, 0, 'bellpham97@gmail.com', 1, 'Pham', 'Vinh', '$2a$10$Pn1WWFmnwjSVzNGuJEKAhOt0vstTdkaYdI0LYIORTM1orBGTqYaWq', NULL, NULL),
(155, NULL, NULL, 0, 0, 'hao@gmail.com', 0, 'HAO', '', '$2a$10$PXyKyXtMYuaEaN7trsosnO1dzQe8erGF.LmhCCHcp2xUBPcvhsuE.', NULL, NULL),
(162, NULL, NULL, 0, 0, 'admin10@ymai.com', 0, 'Admin10', 'Portal', '$2a$10$FCnQAzwLsTpC/tHE1LuoHOkIn7KDZshGJLnlPTNeeGuuz8PKhDLre', NULL, NULL),
(163, NULL, NULL, 0, 0, 'admin11@ymai.com', 0, 'Admin11', 'Portal', '$2a$10$H1ipOMjjOl9aufvgbOdp4OTIbMzDbkYggtEfS.6WQE5qUAb4X/4RG', NULL, NULL),
(164, NULL, NULL, 0, 0, 'admin12@ymai.com', 0, 'Admin12', 'Portal', '$2a$10$Ix8Hagj/vQv1mY2Cck0bgux.FuAlXafMVkLbB.kkUI59Ywsrtukg2', NULL, NULL),
(165, NULL, NULL, 0, 0, 'admin13@ymai.com', 0, 'Admin13', 'Portal', '$2a$10$vECB.TotEc15.Wuvudel0eivwgt3r1y3t9sXAmfJ6cxeWoPoXvjN.', NULL, NULL),
(166, NULL, NULL, 0, 0, 'admin14@ymai.com', 0, 'Admin14', 'Portal', '$2a$10$ibto47po7ycAQWJgrS7XmOQC5MBSnZbpTZ80FujESDFgpZfQc19kK', NULL, NULL),
(167, NULL, NULL, 0, 0, 'admin15@ymai.com', 0, 'Admin15', 'Portal', '$2a$10$iBVl8FGiKJSbjaJ/E3NBBuHidgnmq3zB33rWvH6s910WjmV6g.XlK', NULL, NULL),
(168, NULL, NULL, 0, 0, 'admin16@ymai.com', 0, 'Admin16', 'Portal', '$2a$10$goobAueygtWVeJIp/7APLe3CKc8p2nCmc16WsQ/ihh6tnNIztZ4Bu', NULL, NULL),
(169, NULL, NULL, 0, 0, 'admin17@ymai.com', 0, 'Admin17', 'Portal', '$2a$10$YvTdh/flUXn9wXvSnHuEMehH7yQZ7aZFSUngorwI/6MxM1tJaEAjC', NULL, NULL),
(170, NULL, NULL, 0, 0, 'admin18@ymai.com', 0, 'Admin18', 'Portal', '$2a$10$DB0K.je016kqZnfOf0z/Pe/kRMF9GqKEtt8JSTahbr2PS6pmbviPK', NULL, NULL),
(171, NULL, NULL, 0, 0, 'admin19@ymai.com', 0, 'Admin19', 'Portal', '$2a$10$BgY4KvF6G17XZ6mMehKSyeM1esS3Bvq15r16D2w0kuSTMY.5QOqs6', NULL, NULL),
(177, NULL, NULL, 0, 0, 'beo@gmail.com', 0, 'beo', 'pham', '$2a$10$.NWQvqVEtdpyOEwYx4Vds.j/kRVo1EX1Qxe5dF16ITHsVdfK5qX9m', NULL, NULL),
(178, NULL, NULL, 0, 0, 'bill@gmail.com', 0, 'bill', 'pham', '$2a$10$AnMQKJQZISxdgAXDJHhMZOj3/fk8Jb3cIxoQDMfgCl52rZ0ksBj46', NULL, NULL),
(179, NULL, NULL, 0, 0, 'bill123@gmail.com', 0, 'Pham', 'Vinh', '$2a$10$wmxcp0XytiZqVJHNP7W.P.q.6VmJ8i3F8RkEg9mLbl4zdqWBp0vWa', NULL, NULL),
(180, NULL, NULL, 0, 0, 'staff@gmail.com', 1, 'bell', '', '$2a$10$2v0H.4WM8LHHVSQKQyRnpeBZ53mziBpyEyKfWCIMvkOibSv83thrK', NULL, NULL),
(181, NULL, NULL, 0, 0, 'staff2@gmail.com', 1, 'staff', '', '$2a$10$PscqHGk.LFaX7cuMRk23/.NJpQMQtWBOmSU9UO/8S/ymrFWCQSiSK', NULL, NULL),
(182, NULL, NULL, 0, 0, 'chef2@gmail.com', 1, 'Vinh', '', '$2a$10$IsadM3shFNd3vMbTJ5CPHe8wJr/lLXQ9gD3s8E0IPWQ9PaTS64prm', NULL, NULL),
(183, NULL, NULL, 0, 0, 'staff3@gmail.com', 1, 'staff3', '', '$2a$10$BRxOkGRuq3q8T9ft7HHjMejYeqYF87rZu7RsBy7lLjd26.WxilPz2', NULL, NULL),
(184, NULL, NULL, 0, 0, 'staff4@gmail.com', 1, 'staff4', '', '$2a$10$uFRSKk0ofZTVYP9LlwoTR.Ee/DxG4x/B9pW2sLsaPHO/4.KsmQhYK', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users_roles`
--

CREATE TABLE `users_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users_roles`
--

INSERT INTO `users_roles` (`user_id`, `role_id`) VALUES
(1, 1),
(103, 1),
(154, 13),
(155, 13),
(179, 19),
(180, 1),
(181, 19),
(182, 13),
(183, 19),
(184, 19);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `booking_table`
--
ALTER TABLE `booking_table`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `cart_lines`
--
ALTER TABLE `cart_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK34aasvkrwlysn95bvadyrci2i` (`ingredient_id`),
  ADD KEY `FKopp73kpvssgoafdcajotvtoft` (`table_id`),
  ADD KEY `FKs0j4q1woai7vhm4j21pjavjxv` (`order_id`);

--
-- Chỉ mục cho bảng `category_f`
--
ALTER TABLE `category_f`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `category_t`
--
ALTER TABLE `category_t`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_rfbvkrffamfql7cjmen8v976v` (`email`);

--
-- Chỉ mục cho bảng `income`
--
ALTER TABLE `income`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `income_item`
--
ALTER TABLE `income_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKqtg5wmpt3nrf9561r32y1gqj8` (`income_id`),
  ADD KEY `FKsr7lg1t3myom8lk28nid8jocv` (`ingredient_id`),
  ADD KEY `FKj1r2rjegrbvy0kucwgj7gppvg` (`order_item_id`);

--
-- Chỉ mục cho bảng `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK3ypc1p54980amqq1b88quwufr` (`category_id`),
  ADD KEY `FKptcc01xludxytlml6168ea5p7` (`unit_id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_kb7hyyk7ikg8nfmmeuh9hkdt6` (`income_id`),
  ADD KEY `FKj9f1v0y93l5kjskhgurr9d0ma` (`ingredient_id`),
  ADD KEY `FKp4hdevxo28lcps5nt7duwf3oi` (`table_id`);

--
-- Chỉ mục cho bảng `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK65di14p4dd44f49awv9ieeeim` (`ingredient_id`),
  ADD KEY `FKt4dc2r9nbvbujrljv3e23iibt` (`order_id`);

--
-- Chỉ mục cho bảng `password_reset_token`
--
ALTER TABLE `password_reset_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_a7sckb3vvqaeuvw16u63ygt91` (`customer_id`);

--
-- Chỉ mục cho bảng `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKc5nlnkkq19sg18fxbkdbkmsph` (`table_id`);

--
-- Chỉ mục cho bảng `restaurant_table`
--
ALTER TABLE `restaurant_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK5x41yktgmfvddtj2etfkx6ycg` (`category_id`);

--
-- Chỉ mục cho bảng `restaurant_table_ingredients`
--
ALTER TABLE `restaurant_table_ingredients`
  ADD PRIMARY KEY (`restaurant_table_id`,`ingredients_id`),
  ADD KEY `FK9q8kqrmoye628tmemyufds3ir` (`ingredients_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_ofx66keruapi6vyqpv6f2or37` (`name`);

--
-- Chỉ mục cho bảng `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`);

--
-- Chỉ mục cho bảng `users_roles`
--
ALTER TABLE `users_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `FKj6m8fwv7oqv74fcehir1a9ffy` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `booking_table`
--
ALTER TABLE `booking_table`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `cart_lines`
--
ALTER TABLE `cart_lines`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=662;

--
-- AUTO_INCREMENT cho bảng `category_f`
--
ALTER TABLE `category_f`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `category_t`
--
ALTER TABLE `category_t`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT cho bảng `income`
--
ALTER TABLE `income`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `income_item`
--
ALTER TABLE `income_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT cho bảng `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=459;

--
-- AUTO_INCREMENT cho bảng `order_item`
--
ALTER TABLE `order_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202;

--
-- AUTO_INCREMENT cho bảng `password_reset_token`
--
ALTER TABLE `password_reset_token`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `reservation`
--
ALTER TABLE `reservation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `restaurant_table`
--
ALTER TABLE `restaurant_table`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `tables`
--
ALTER TABLE `tables`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `unit`
--
ALTER TABLE `unit`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=185;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `cart_lines`
--
ALTER TABLE `cart_lines`
  ADD CONSTRAINT `FK34aasvkrwlysn95bvadyrci2i` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`),
  ADD CONSTRAINT `FKopp73kpvssgoafdcajotvtoft` FOREIGN KEY (`table_id`) REFERENCES `restaurant_table` (`id`),
  ADD CONSTRAINT `FKs0j4q1woai7vhm4j21pjavjxv` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Các ràng buộc cho bảng `income_item`
--
ALTER TABLE `income_item`
  ADD CONSTRAINT `FKj1r2rjegrbvy0kucwgj7gppvg` FOREIGN KEY (`order_item_id`) REFERENCES `order_item` (`id`),
  ADD CONSTRAINT `FKqtg5wmpt3nrf9561r32y1gqj8` FOREIGN KEY (`income_id`) REFERENCES `income` (`id`),
  ADD CONSTRAINT `FKsr7lg1t3myom8lk28nid8jocv` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`);

--
-- Các ràng buộc cho bảng `ingredient`
--
ALTER TABLE `ingredient`
  ADD CONSTRAINT `FK3ypc1p54980amqq1b88quwufr` FOREIGN KEY (`category_id`) REFERENCES `category_f` (`id`),
  ADD CONSTRAINT `FKptcc01xludxytlml6168ea5p7` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`id`);

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK61ibxm6ehevavyd64t2g247vt` FOREIGN KEY (`income_id`) REFERENCES `income` (`id`),
  ADD CONSTRAINT `FKj9f1v0y93l5kjskhgurr9d0ma` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`),
  ADD CONSTRAINT `FKp4hdevxo28lcps5nt7duwf3oi` FOREIGN KEY (`table_id`) REFERENCES `restaurant_table` (`id`);

--
-- Các ràng buộc cho bảng `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `FK65di14p4dd44f49awv9ieeeim` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`),
  ADD CONSTRAINT `FKt4dc2r9nbvbujrljv3e23iibt` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Các ràng buộc cho bảng `password_reset_token`
--
ALTER TABLE `password_reset_token`
  ADD CONSTRAINT `FKfrbnswmufpmqin2lwb65fegs0` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Các ràng buộc cho bảng `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `FKc5nlnkkq19sg18fxbkdbkmsph` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`);

--
-- Các ràng buộc cho bảng `restaurant_table`
--
ALTER TABLE `restaurant_table`
  ADD CONSTRAINT `FK5x41yktgmfvddtj2etfkx6ycg` FOREIGN KEY (`category_id`) REFERENCES `category_t` (`id`);

--
-- Các ràng buộc cho bảng `restaurant_table_ingredients`
--
ALTER TABLE `restaurant_table_ingredients`
  ADD CONSTRAINT `FK9q8kqrmoye628tmemyufds3ir` FOREIGN KEY (`ingredients_id`) REFERENCES `ingredient` (`id`),
  ADD CONSTRAINT `FKbg2dodpsmf9frs1udtlub4gpy` FOREIGN KEY (`restaurant_table_id`) REFERENCES `restaurant_table` (`id`);

--
-- Các ràng buộc cho bảng `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `FK2o0jvgh89lemvvo17cbqvdxaa` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FKj6m8fwv7oqv74fcehir1a9ffy` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
