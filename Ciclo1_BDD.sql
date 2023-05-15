-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 05, 2023 at 07:37 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `devsdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `alumno`
--

CREATE TABLE `alumno` (
  `idAlumno` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `contrasena` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `examen`
--

CREATE TABLE `examen` (
  `idExamen` int(11) NOT NULL,
  `idProfesor` int(11) NOT NULL,
  `cantidadPreguntas` int(11) NOT NULL,
  `fechaCreacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `examenalumno`
--

CREATE TABLE `examenalumno` (
  `idExamen` int(11) NOT NULL,
  `idAlumno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `preguntaexamen`
--

CREATE TABLE `preguntaexamen` (
  `idPregunta` int(11) NOT NULL,
  `idExamen` int(11) NOT NULL,
  `pregunta` varchar(45) NOT NULL,
  `respuesta1` varchar(45) NOT NULL,
  `respuesta2` varchar(45) NOT NULL,
  `respuesta3` varchar(45) DEFAULT NULL,
  `respuesta4` varchar(45) DEFAULT NULL,
  `respuestaCorrecta` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `preguntaexamenalumno`
--

CREATE TABLE `preguntaexamenalumno` (
  `idPreguntaExamen` int(11) NOT NULL,
  `idAlumno` int(11) NOT NULL,
  `correcto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `profesor`
--

CREATE TABLE `profesor` (
  `idProfesor` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `institucion` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `contrasena` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `profesor`
--

INSERT INTO `profesor` (`idProfesor`, `nombre`, `apellidos`, `institucion`, `correo`, `contrasena`) VALUES
(1, 'Jorge', 'Cooley Magallanes', 'Tec', 'correo@tec.mx', '12345');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`idAlumno`);

--
-- Indexes for table `examen`
--
ALTER TABLE `examen`
  ADD PRIMARY KEY (`idExamen`),
  ADD KEY `fkProfesor` (`idProfesor`);

--
-- Indexes for table `examenalumno`
--
ALTER TABLE `examenalumno`
  ADD PRIMARY KEY (`idExamen`,`idAlumno`),
  ADD KEY `fkAlum` (`idAlumno`);

--
-- Indexes for table `preguntaexamen`
--
ALTER TABLE `preguntaexamen`
  ADD PRIMARY KEY (`idPregunta`),
  ADD KEY `fkExamen` (`idExamen`);

--
-- Indexes for table `preguntaexamenalumno`
--
ALTER TABLE `preguntaexamenalumno`
  ADD PRIMARY KEY (`idPreguntaExamen`,`idAlumno`),
  ADD KEY `fkAlumno` (`idAlumno`);

--
-- Indexes for table `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`idProfesor`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alumno`
--
ALTER TABLE `alumno`
  MODIFY `idAlumno` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `examen`
--
ALTER TABLE `examen`
  MODIFY `idExamen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `preguntaexamen`
--
ALTER TABLE `preguntaexamen`
  MODIFY `idPregunta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `profesor`
--
ALTER TABLE `profesor`
  MODIFY `idProfesor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `examen`
--
ALTER TABLE `examen`
  ADD CONSTRAINT `fkProfesor` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idProfesor`);

--
-- Constraints for table `examenalumno`
--
ALTER TABLE `examenalumno`
  ADD CONSTRAINT `fkAlum` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`),
  ADD CONSTRAINT `fkExam` FOREIGN KEY (`idExamen`) REFERENCES `examen` (`idExamen`);

--
-- Constraints for table `preguntaexamen`
--
ALTER TABLE `preguntaexamen`
  ADD CONSTRAINT `fkExamen` FOREIGN KEY (`idExamen`) REFERENCES `examen` (`idExamen`);

--
-- Constraints for table `preguntaexamenalumno`
--
ALTER TABLE `preguntaexamenalumno`
  ADD CONSTRAINT `fkAlumno` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`),
  ADD CONSTRAINT `fkPreguntaExamen` FOREIGN KEY (`idPreguntaExamen`) REFERENCES `preguntaexamen` (`idPregunta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
