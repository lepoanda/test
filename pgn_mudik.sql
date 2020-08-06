-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Agu 2020 pada 09.54
-- Versi server: 10.1.37-MariaDB
-- Versi PHP: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pgn_mudik`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `memo_trip`
--

CREATE TABLE `memo_trip` (
  `memo_id` int(11) NOT NULL,
  `ticket` int(11) NOT NULL,
  `rute_awal` varchar(111) NOT NULL,
  `rute_tujuan` varchar(111) NOT NULL,
  `slot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `ms_transport`
--

CREATE TABLE `ms_transport` (
  `transport_id` int(11) NOT NULL,
  `transport_type` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `ms_transport`
--

INSERT INTO `ms_transport` (`transport_id`, `transport_type`) VALUES
(1, 'Bus'),
(2, 'Kapal');

-- --------------------------------------------------------

--
-- Struktur dari tabel `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL,
  `booking_code` int(11) NOT NULL,
  `users` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '1. Verif | 2. Not Verif',
  `total_users` int(11) NOT NULL,
  `ticket_code` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `ticket`
--

INSERT INTO `ticket` (`ticket_id`, `booking_code`, `users`, `status`, `total_users`, `ticket_code`) VALUES
(2, 1010, 2, 1, 3, 'LNeIjcF'),
(10, 1817, 2, 2, 10, '0'),
(11, 1231, 2, 2, 5, '0'),
(12, 1231, 4, 2, 7, '0');

-- --------------------------------------------------------

--
-- Struktur dari tabel `trip`
--

CREATE TABLE `trip` (
  `trip_id` int(111) NOT NULL,
  `transport` int(11) NOT NULL,
  `rute_awal` varchar(111) NOT NULL,
  `rute_tujuan` varchar(111) NOT NULL,
  `jadwal` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `trip`
--

INSERT INTO `trip` (`trip_id`, `transport`, `rute_awal`, `rute_tujuan`, `jadwal`) VALUES
(1010, 1, 'Jakarta', 'Bandung', '2020-08-05 07:00:00'),
(1231, 1, 'Bogor', 'Bandung', '2020-08-06 10:13:00'),
(1817, 1, 'Jogjakarta', 'Depok', '2020-08-19 14:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` tinyint(4) NOT NULL COMMENT '1. Admin | 2. Client'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `role`) VALUES
(2, 'lepo', '', '$2y$10$ChvQno/nSJwjx3pP38272.hHrs1KvRLZotdDCpBcb2MM01G7eaF/i', 2),
(3, 'admin', '', '$2y$10$kWNWSxNd.k3bZL7dd8g2eOfK5EiU7WW5CSHXQiKZcQWIXOeeTZcmK', 1),
(4, 'kiki', '', '$2y$10$pJ1GBjRv1cIqwpSmfu95qeNujojGme8kqDUr4YrOnXJ8qoXacQQ/y', 2);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `memo_trip`
--
ALTER TABLE `memo_trip`
  ADD PRIMARY KEY (`memo_id`),
  ADD KEY `ticket` (`ticket`);

--
-- Indeks untuk tabel `ms_transport`
--
ALTER TABLE `ms_transport`
  ADD PRIMARY KEY (`transport_id`);

--
-- Indeks untuk tabel `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `booking_code` (`booking_code`),
  ADD KEY `users` (`users`);

--
-- Indeks untuk tabel `trip`
--
ALTER TABLE `trip`
  ADD PRIMARY KEY (`trip_id`),
  ADD KEY `transport` (`transport`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `memo_trip`
--
ALTER TABLE `memo_trip`
  MODIFY `memo_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `ms_transport`
--
ALTER TABLE `ms_transport`
  MODIFY `transport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `ticket`
--
ALTER TABLE `ticket`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `memo_trip`
--
ALTER TABLE `memo_trip`
  ADD CONSTRAINT `memo_trip_ibfk_1` FOREIGN KEY (`ticket`) REFERENCES `ticket` (`ticket_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`booking_code`) REFERENCES `trip` (`trip_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`users`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trip`
--
ALTER TABLE `trip`
  ADD CONSTRAINT `trip_ibfk_1` FOREIGN KEY (`transport`) REFERENCES `ms_transport` (`transport_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
