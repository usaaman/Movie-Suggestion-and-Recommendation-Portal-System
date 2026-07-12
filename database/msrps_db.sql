-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2025 at 09:21 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `msrps_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `client_list`
--

CREATE TABLE `client_list` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `middlename` text DEFAULT NULL,
  `lastname` varchar(250) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0=not verified, 1 = verified',
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_list`
--

INSERT INTO `client_list` (`id`, `firstname`, `middlename`, `lastname`, `gender`, `email`, `password`, `avatar`, `last_login`, `status`, `date_added`, `date_updated`) VALUES
(4, 'naeem', '', 'kayani', 'Male', 'naeemkayani39@gmail.com', '202cb962ac59075b964b07152d234b70', NULL, NULL, 1, '2025-01-01 21:05:42', NULL),
(5, 'abubakar', '', 'talat', 'Male', 'abubakar03@gmail.com', '202cb962ac59075b964b07152d234b70', NULL, NULL, 1, '2025-01-08 22:48:11', NULL),
(6, 'abdul', '', 'waseh', 'Male', 'abdul@gmail.com', '202cb962ac59075b964b07152d234b70', NULL, NULL, 1, '2025-01-10 12:10:54', NULL),
(7, 'Wajih', '', 'Ul Qammar', 'Male', 'wajiul.qammar@gmai.com', '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 1, '2025-01-10 12:58:05', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `genre_list`
--

CREATE TABLE `genre_list` (
  `id` int(30) NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genre_list`
--

INSERT INTO `genre_list` (`id`, `name`, `description`, `date_created`, `date_updated`) VALUES
(1, 'Comedy', 'Comedy', '2021-12-22 09:34:57', NULL),
(2, 'Action', 'Action', '2021-12-22 09:35:06', NULL),
(3, 'Horror', 'Horror', '2021-12-22 09:35:14', NULL),
(4, 'Thriller', 'Thriller', '2021-12-22 09:35:30', NULL),
(5, 'Fiction', 'Fiction', '2021-12-22 09:35:40', NULL),
(6, 'Romance', 'Romance', '2021-12-22 09:35:49', NULL),
(7, 'Crime', 'Crime', '2021-12-22 09:36:00', NULL),
(8, 'Drama', 'Drama', '2021-12-22 09:36:51', NULL),
(9, 'RomCom', 'RomanticComedy', '2021-12-22 09:37:21', NULL),
(10, 'Martial Arts', 'Martial Arts', '2021-12-22 09:37:33', NULL),
(11, 'Sci-Fi', 'Science Fiction', '2021-12-22 09:37:59', NULL),
(12, 'Adventure', 'Adventure', '2021-12-22 09:38:14', NULL),
(13, 'Fantasy', 'Fantasy', '2021-12-22 09:38:26', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `message_list`
--

CREATE TABLE `message_list` (
  `id` int(30) NOT NULL,
  `fullname` text NOT NULL,
  `contact` text NOT NULL,
  `email` text NOT NULL,
  `message` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `message_list`
--

INSERT INTO `message_list` (`id`, `fullname`, `contact`, `email`, `message`, `status`, `date_created`) VALUES
(3, 'Naeem Kayani', '03135305649 / 03430745340', 'naeemkayani39@gmail.com', 'hhhhyyy', 1, '2025-01-01 22:50:40');

-- --------------------------------------------------------

--
-- Table structure for table `movie_list`
--

CREATE TABLE `movie_list` (
  `id` int(30) NOT NULL,
  `title` text NOT NULL,
  `genres` text NOT NULL,
  `director` text NOT NULL,
  `produced` text NOT NULL,
  `writter` text NOT NULL,
  `actors` text NOT NULL,
  `description` text NOT NULL,
  `image_path` text DEFAULT NULL,
  `trailer_link` text DEFAULT NULL,
  `release_date` date NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_list`
--

INSERT INTO `movie_list` (`id`, `title`, `genres`, `director`, `produced`, `writter`, `actors`, `description`, `image_path`, `trailer_link`, `release_date`, `date_created`, `date_updated`) VALUES
(1, 'The Tomorrow War', '5,11', 'Christopher McKay', 'David Ellison, Dana Goldberg, Don Granger, David S. Goyer, Jules Daly, and Adam Kolbrenner', 'Zach Dean', 'Christopher Michael Pratt, Yvonne Strahovski, Ryan Kiera Armstrong, J. K. Simmons, Betty Gilpin, Sam Richardson, Edwin Hodge, Jasmine Mathews, Keith Powers', 'In December 2022, biology teacher and former Green Beret, Dan Forester, fails to get a job at the Army Research Laboratory. During the broadcast of the World Cup, soldiers from the year 2051 arrive to warn that, in their time, humanity is on the brink of extinction due to a war with alien invaders, referred to as the \"Whitespikes.\" In November 2048, the Whitespikes suddenly appear in northern Russia and proceed to kill the majority of the humans within three years. In response, the world\'s present-day militaries are sent into the future via a wormhole device called the \"Jumplink,\" but fewer than 30% survive their seven-day deployment, prompting an international draft.\r\n\r\nDan receives his draft notice and tells his wife Emmy and daughter, Muri. Emmy suggests that they should run and talks Dan into visiting his estranged father James, a mechanical engineer, for help in removing the draft band attached to his arm. Dan\'s father left him and his mother after he returned from the Vietnam War because he felt he was too dangerous to remain with them. Dan says he does not want his father\'s help and leaves. Dan reports to basic training with other draftees where they are briefed by future soldiers. Dan deduces with fellow draftee Charlie, a scientist, that all draftees have died before the war starts to prevent a paradox.', 'uploads/movie-1.png?v=1640157585', NULL, '2021-07-02', '2025-01-01 11:19:12', '2025-01-02 08:57:29'),
(2, 'Outside the Wire', '5,11', 'Mikael Håfström', 'Brian Kavanaugh-Jones\r\nAnthony Mackie\r\nBen Pugh\r\nErica Steinberg\r\nJason Spire\r\nArash Amel', 'Rowan Athale, Rob Yescombe, Alice Allemano', '	\r\nAnthony Mackie\r\nDamson Idris\r\nEmily Beecham\r\nMichael Kelly\r\nPilou Asbæk', 'In 2036, a civil war between pro-Russian insurgents and local resistances in Ukraine leads the US to deploy peacekeeping forces. During an operation, a team of United States Marines and robotic soldiers, individually referred to by the acronym \"G.U.M.P.\", are ambushed. Disobeying an order, drone pilot 1st Lt. Harp deploys a Hellfire missile in a drone strike against a suspected enemy launcher, killing two Marines caught in the killzone but saving the 38 Marines who would have been killed by the launcher. As punishment, Harp is sent to Camp Nathaniel, the US base of operations in Ukraine where he is assigned to Captain Leo, a highly advanced and experimental android super-soldier masquerading as a human officer.\r\n\r\nHarp and Leo set out on a mission to prevent terrorist Victor Koval from gaining control of a network of Cold War–era nuclear missile silos, under the cover of delivering vaccines to a refugee camp. On the way, they respond to a reported attack on a friendly aid truck, resulting in a stand-off between the Marines and armed locals. After a G.U.M.P. shoots a local who threw a rock, Captain Leo negotiates a peaceful solution by giving the locals the contents of the aid truck. However, pro-Russian insurgents ambush the locals and Marines, leading to a firefight. This forces Leo and Harp to travel to the refugee camp on foot, while the Marines remain behind to engage the insurgents.\r\n\r\nAfter arriving at the refugee compound, Leo and Harp are shot at by an insurgent, who kills some civilians. Leo tortures the insurgent for information, before leaving him to be killed by the gathered mob. Leo and Harp meet their contact Sofiya, a resistance leader. Sofiya leads them to an arms dealer who knows the location of a bank vault containing nuclear launch codes that Koval is looking for. Harp and Leo travel to the bank and are met by Koval\'s forces which include several G.U.M.P.s. While Harp helps rescue civilians caught in a crossfire between US and Russian G.U.M.P.s, Leo retrieves the codes but cannot find Koval. A drone strike called in by Eckhart destroys the bank and several buildings, leading the military command to believe both Koval dead and Leo destroyed.\r\n\r\nHarp reunites with Leo who tells him that he has his own plans for the codes, and has been manipulating Harp into helping him evade the eye of military command. He knocks out Harp and leaves him on the side of the road where he is picked up by Sofiya\'s men. Leo meets with Koval to give him the codes but kills him when Koval refuses to give Leo access to a nuclear missile silo. Harp informs Sofiya and his commander of Leo\'s actions, and they realize that Leo is planning to launch the nuclear missiles to strike the United States, in order to prevent them from fighting more wars in the future. Harp volunteers to infiltrate the silo and finds Leo has taken over. He disables Leo but not before Leo initiates the launch of a missile, explaining that his goal was for the android super-soldier program to end in failure. Harp escapes as the silo is destroyed by a drone strike before the missile can launch; destroying Leo. Harp returns to Camp Nathaniel and receives praise from his commander, who informs him that he is returning home. Harp then leaves the base.', 'uploads/movie-2.png?v=1640157558', NULL, '2021-01-15', '2025-01-01 14:07:45', '2025-01-02 08:58:44'),
(13, 'kgf 3', '5,11', 'M. Night Shyamalan', 'Jason,Blum', 'M, Night Shyamalan', 'James, McAvoy, Anya Taylor-Joy, Betty Buckley, Haley Lu Richardson, Jessica Sula,', ' Split follows the harrowing story of three girls who are kidnapped by a man suffering from dissociative identity disorder. The kidnapper possesses 23 distinct personalities, and the girls must find a way to escape before the emergence of a terrifying new 24th personality. The film blends elements of psychological horror and thriller, showcasing themes of identity and trauma. With a budget of $9 million, it grossed approximately $278.5 million worldwide, marking it as a significant success for both the director and the production company.', NULL, NULL, '2025-01-09', '2025-01-10 12:32:02', '2025-01-11 00:31:12'),
(34, 'abdul', '1,5', 'wajih', 'wajih', 'wajih', 'wajih', 'hkjgsdfjurdfghjklljhgfdfhj', NULL, NULL, '2025-01-10', '2025-01-10 13:08:21', NULL),
(35, 'hhjikj', '2', 'nkjnkkhk', 'jnjhkk', 'mknkjhk', 'hjjkokj', 'nknkkjhujh', NULL, NULL, '2024-12-31', '2025-01-11 00:31:58', NULL),
(38, 'Sample Voting', '6', 'kjij', 'kjjhh', 'jjhhhhh', 'iu8ik', 'nnnm', NULL, NULL, '2025-01-01', '2025-01-11 01:44:46', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `recommendations`
--

CREATE TABLE `recommendations` (
  `id` int(30) NOT NULL,
  `client_id` int(30) NOT NULL,
  `genre_id` int(30) NOT NULL,
  `movie_id` int(30) DEFAULT NULL,
  `recommend_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recommendations`
--

INSERT INTO `recommendations` (`id`, `client_id`, `genre_id`, `movie_id`, `recommend_date`) VALUES
(1, 4, 5, 2, '2025-01-10 11:00:00'),
(2, 5, 11, 1, '2025-01-11 15:30:00'),
(3, 6, 13, NULL, '2025-01-12 09:00:00'),
(4, 7, 3, 13, '2025-01-12 13:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `review_list`
--

CREATE TABLE `review_list` (
  `id` int(30) NOT NULL,
  `movie_id` int(30) NOT NULL,
  `title` text NOT NULL,
  `comment` text NOT NULL,
  `rating` float NOT NULL DEFAULT 0,
  `client_id` int(30) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review_list`
--

INSERT INTO `review_list` (`id`, `movie_id`, `title`, `comment`, `rating`, `client_id`, `date_created`, `date_updated`) VALUES
(7, 2, 'Sample Voting', 'nice', 4, 4, '2025-01-01 21:54:05', NULL),
(8, 1, 'naeem', 'this is bad', 1, 4, '2025-01-02 11:34:16', NULL),
(11, 2, 'abdul', 'its bad ', 1, 6, '2025-01-10 12:12:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sentiment_keywords`
--

CREATE TABLE `sentiment_keywords` (
  `id` int(30) NOT NULL,
  `keyword` text NOT NULL,
  `score` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sentiment_keywords`
--

INSERT INTO `sentiment_keywords` (`id`, `keyword`, `score`) VALUES
(1, 'great', 5),
(2, 'Good', 4),
(3, 'Nice', 4),
(4, 'Amazing', 5),
(5, 'Fantastic', 5),
(6, 'very', 5),
(7, 'Best', 5),
(8, 'Wonderful', 5),
(9, 'adore', 4),
(10, 'adoring', 4),
(11, 'adoringly', 5),
(12, 'affordable', 4),
(13, 'afford', 4),
(14, 'amaze', 4),
(15, 'amazed', 4),
(16, 'appreciable', 4),
(17, 'applaud', 4),
(18, 'Bad', 1),
(19, 'awesome', 5),
(20, 'award', 5),
(21, 'win', 5),
(22, 'winning', 5),
(23, 'loss', 1),
(24, 'lose', 2),
(25, 'beautiful', 5),
(26, 'bonus', 3),
(27, 'bonuses', 3),
(28, 'brightest', 5),
(29, 'brighter', 4),
(30, 'bright', 3),
(31, 'classic', 3),
(32, 'dazzle', 3),
(33, 'dazling', 4),
(34, 'dedicated', 3),
(35, 'delight', 3),
(36, 'delightful', 4),
(37, 'delightfully', 5),
(38, 'delightfulness', 5),
(39, 'excelent', 5),
(40, 'excellant', 5),
(41, 'exceeded', 5),
(42, 'exceeds', 5),
(43, 'excel', 4),
(44, 'famous', 4),
(45, 'famously', 5),
(46, 'fine', 3),
(47, 'finest', 4),
(48, 'abnormal', 1),
(49, 'abolish', 1),
(50, 'don\'t', 1),
(51, 'dont', 1),
(52, 'wont', 1),
(53, 'absurd', 2),
(54, 'absurdity', 1),
(55, 'absurdly', 2),
(56, 'absurdness', 1),
(57, 'alarmed', 3),
(58, 'Alarming', 2),
(59, 'alarmingly', 1),
(60, 'badly', 1),
(61, 'bash', 2),
(62, 'bashed', 3),
(63, 'bashful', 1),
(64, 'bashing', 3),
(65, 'bias', 2),
(66, 'biased', 3),
(67, 'careless', 2),
(68, 'carelessness', 1),
(69, 'concern', 3),
(70, 'concerned', 3),
(71, 'condemn', 2),
(72, 'condemnable', 3),
(73, 'defect', 3),
(74, 'defective', 2),
(75, 'devilry', 1),
(76, 'danger', 3),
(77, 'dangerous', 1),
(78, 'harm', 3),
(79, 'harmful', 1),
(80, 'disgrace', 3),
(81, 'disgraced', 3),
(82, 'disgraceful', 2),
(83, 'disgracefully', 1);

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'MOVIE RECOMMENDATION SYSTEM_'),
(6, 'short_name', 'MovieMatch'),
(11, 'logo', 'uploads/logo-1640136453.png'),
(13, 'user_avatar', 'uploads/user_avatar.jpg'),
(14, 'cover', 'uploads/cover-1640136453.png'),
(15, 'content', 'Array'),
(16, 'email', 'info@xyzmovierevie.com'),
(17, 'contact', '03135305649 / 03430745340'),
(18, 'from_time', '11:00'),
(19, 'to_time', '21:30'),
(20, 'address', 'XYZ Street, There City, Here, 2306'),
(21, 'church_name', 'ABC Baptist Church'),
(22, 'religion', 'Baptist');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `middlename` text DEFAULT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0=not verified, 1 = verified',
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `middlename`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `status`, `date_added`, `date_updated`) VALUES
(1, 'Adminstrator', NULL, 'Admin', 'admin', '0192023a7bbd73250516f069df18b500', 'uploads/avatar-1.png?v=1639468007', NULL, 1, 1, '2021-01-20 14:02:37', '2025-01-11 01:38:41'),
(4, 'naeem', NULL, 'kayani', 'naeem123', '202cb962ac59075b964b07152d234b70', NULL, NULL, 1, 1, '2025-01-01 22:32:26', '2025-01-11 01:45:25');

-- --------------------------------------------------------

--
-- Table structure for table `watch_history`
--

CREATE TABLE `watch_history` (
  `id` int(30) NOT NULL,
  `client_id` int(30) NOT NULL,
  `movie_id` int(30) NOT NULL,
  `watch_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `watch_history`
--

INSERT INTO `watch_history` (`id`, `client_id`, `movie_id`, `watch_date`) VALUES
(1, 4, 1, '2025-01-05 10:30:00'),
(2, 5, 2, '2025-01-06 14:45:00'),
(3, 6, 1, '2025-01-07 18:00:00'),
(4, 7, 13, '2025-01-08 21:15:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `client_list`
--
ALTER TABLE `client_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `genre_list`
--
ALTER TABLE `genre_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `message_list`
--
ALTER TABLE `message_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movie_list`
--
ALTER TABLE `movie_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `genre_id` (`genre_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- Indexes for table `review_list`
--
ALTER TABLE `review_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- Indexes for table `sentiment_keywords`
--
ALTER TABLE `sentiment_keywords`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `watch_history`
--
ALTER TABLE `watch_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client_list`
--
ALTER TABLE `client_list`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `genre_list`
--
ALTER TABLE `genre_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `message_list`
--
ALTER TABLE `message_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `movie_list`
--
ALTER TABLE `movie_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `recommendations`
--
ALTER TABLE `recommendations`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `review_list`
--
ALTER TABLE `review_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `sentiment_keywords`
--
ALTER TABLE `sentiment_keywords`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `watch_history`
--
ALTER TABLE `watch_history`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD CONSTRAINT `recommendations_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client_list` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recommendations_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre_list` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recommendations_ibfk_3` FOREIGN KEY (`movie_id`) REFERENCES `movie_list` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `review_list`
--
ALTER TABLE `review_list`
  ADD CONSTRAINT `review_list_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie_list` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_list_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client_list` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `watch_history`
--
ALTER TABLE `watch_history`
  ADD CONSTRAINT `watch_history_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client_list` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `watch_history_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie_list` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
