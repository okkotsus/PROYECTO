-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-05-2025 a las 04:19:35
-- Versión del servidor: 10.4.32-MariaDB-log
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hotel`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_Clientes` (IN `letra` VARCHAR(10))   SELECT * FROM clientes WHERE pais LIKE concat('%',letra, '%')$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularDESCUENTOIF` (`precio` DECIMAL(10,2), `noches` INT) RETURNS DECIMAL(10,2) DETERMINISTIC BEGIN
    DECLARE descuento DECIMAL(10,2) DEFAULT 0;

    -- Aplicar el descuento si las noches son mayores a 3
    IF noches > 3 THEN 
        SET descuento = precio * 0.15;
    ELSE 
        SET descuento = 0; -- Sin descuento
    END IF;

    RETURN descuento;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditorias`
--

CREATE TABLE `auditorias` (
  `id_auditorias` int(11) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `accion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auditorias`
--

INSERT INTO `auditorias` (`id_auditorias`, `usuario`, `accion`) VALUES
(6, 'root', 'Se elimino un cliente: JORGE (JORGE@gmai, mexico)'),
(7, 'root', 'Se modifico un cliente: ricardo (JORGE@gmai, mexico)'),
(8, 'root', 'Se modifico un cliente: mario (mario@gmai, italia)'),
(9, 'root', 'Se modifico un cliente: gerardo hugo (gerardo@gm, mexico)'),
(10, 'root', 'Se modifico un cliente: parra (parra@gmail.com, mexico)'),
(11, 'root', 'Se modifico un cliente: parra (parra@gmail.com, mexico)'),
(12, 'root', 'Se modifico un cliente: Alberto (alberto@gmail.com, mexico)'),
(13, 'root', 'Se modifico un cliente: pepe (mario@gmai, italia)'),
(14, 'root', 'Se modifico un cliente: Ana Lopez (ana@gmail.com, Mexico)'),
(15, 'root', 'Se modifico un cliente: Ana lopez (ana@.com, Mexico)'),
(16, 'root', 'Se modifico un cliente: Ana Lopez (ana, Mexico)'),
(17, 'root', 'Se modifico un cliente: Ana Lopez (ana@gmail.com, Mexico)'),
(18, 'root', 'Se modifico un cliente: Emilio Lopez (emi@gmail.com, Mexico)'),
(19, 'root', 'Se modifico un cliente: Alberto (alberto@gmail.com, mexico)'),
(20, 'root', 'Se modifico un cliente: Emilio Lopez (emi@gmial.com, España)'),
(21, 'root', 'Se modifico un cliente: Alberto (alberto@gmail.com, mexico)');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `Id_Clientes` int(11) NOT NULL,
  `Nombre` varchar(110) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pais` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`Id_Clientes`, `Nombre`, `email`, `pais`) VALUES
(1, 'Jose', 'pepe@gmail.com', 'mexico'),
(2, 'uriel\r\n', 'uriel@gmai', 'italia'),
(3, 'mauricio', 'mauricio@g', 'mexico'),
(4, 'gerardo', 'g@gmail', 'chile'),
(5, 'hector', 'JORGE@gmai', 'mexico'),
(6, 'hugo', 'hugo@gm', 'mexico'),
(7, 'Alberto', 'alberto@gmail.com', 'mexico'),
(11, 'Emilio Lopez', 'emi@gmial.com', 'España'),
(18, 'diego', 'diego@gmail.com', 'mexico'),
(21, 'victor', 'victro@gmail.com', 'hungria'),
(22, 'ricardo', 'hectorinkakashi01@gmail.com', 'belgica'),
(23, 'hugito', 'h@gmail.com', 'cevilla'),
(24, 'diego', 'diego@hdhj.com', 'nicaragua');

--
-- Disparadores `clientes`
--
DELIMITER $$
CREATE TRIGGER `actualizacion` AFTER UPDATE ON `clientes` FOR EACH ROW BEGIN
    INSERT INTO auditorias (
        usuario,
        accion
    ) VALUES (
        SUBSTRING_INDEX(USER(), '@',  1), -- Obtiene el usuario de MySQL
        CONCAT('Se modifico un cliente: ', OLD.nombre, ' (', OLD.email, ', ', OLD.pais, ')') 
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id_Empleados` int(11) NOT NULL,
  `usuario` varchar(20) NOT NULL,
  `contraseña` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id_Empleados`, `usuario`, `contraseña`) VALUES
(1, 'carlos77', 1234567),
(2, 'silvia78', 1234567);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservacion`
--

CREATE TABLE `reservacion` (
  `id_reservaciones` int(11) NOT NULL,
  `id_clientes` int(10) NOT NULL,
  `t_habitacion` varchar(20) NOT NULL,
  `precio` varchar(10) NOT NULL,
  `f_inicio` date NOT NULL,
  `f_fin` date NOT NULL,
  `h_cantidad` int(10) NOT NULL,
  `id_habitacion` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservacion`
--

INSERT INTO `reservacion` (`id_reservaciones`, `id_clientes`, `t_habitacion`, `precio`, `f_inicio`, `f_fin`, `h_cantidad`, `id_habitacion`) VALUES
(39, 1, 'normal', '400.0', '2025-12-11', '2025-12-18', 2, 1),
(40, 2, 'normal', '200.0', '2025-11-12', '2025-11-18', 1, 2),
(43, 7, 'suite', '400.0', '2025-11-12', '2025-11-27', 2, 10),
(44, 4, 'normal', '3000.0', '2026-12-11', '2026-12-19', 3, 7),
(45, 7, 'normal', '1000.0', '2025-04-09', '2025-04-14', 1, 3),
(46, 7, 'normal', '1000.0', '2025-05-03', '2025-05-10', 1, 9);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditorias`
--
ALTER TABLE `auditorias`
  ADD PRIMARY KEY (`id_auditorias`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`Id_Clientes`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id_Empleados`);

--
-- Indices de la tabla `reservacion`
--
ALTER TABLE `reservacion`
  ADD PRIMARY KEY (`id_reservaciones`),
  ADD KEY `id_clientes` (`id_clientes`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditorias`
--
ALTER TABLE `auditorias`
  MODIFY `id_auditorias` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `Id_Clientes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id_Empleados` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `reservacion`
--
ALTER TABLE `reservacion`
  MODIFY `id_reservaciones` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `reservacion`
--
ALTER TABLE `reservacion`
  ADD CONSTRAINT `reservacion_ibfk_1` FOREIGN KEY (`id_clientes`) REFERENCES `clientes` (`Id_Clientes`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
