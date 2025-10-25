-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-10-2025 a las 02:15:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `oficina_asuntos_sociales`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `id_departamento` int(11) NOT NULL,
  `nombre_departamento` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`id_departamento`, `nombre_departamento`, `descripcion`, `fecha_creacion`) VALUES
(1, 'Departamento de Cultura', 'Control de estudiantes en grupos o actividades culturales', '2025-10-25 00:12:29'),
(2, 'Departamento de Deportes', 'Control de estudiantes en actividades deportivas', '2025-10-25 00:12:29'),
(3, 'Departamento de Formación Patriótica', 'Control de estudiantes en actividades protocolares', '2025-10-25 00:12:29'),
(4, 'Departamento de UNIDIVE', 'Control de estudiantes en condiciones especiales (discapacidad o médicos)', '2025-10-25 00:12:29'),
(5, 'Departamento de Atención Integral', 'Control de estudiantes becados', '2025-10-25 00:12:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `id_estudiante` int(11) NOT NULL,
  `cedula` varchar(20) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `activo` tinyint(1) DEFAULT 1,
  `id_tipo_beca` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante_departamento`
--

CREATE TABLE `estudiante_departamento` (
  `id_relacion` int(11) NOT NULL,
  `id_estudiante` int(11) NOT NULL,
  `id_departamento` int(11) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registros_beca`
--

CREATE TABLE `registros_beca` (
  `id_registro` int(11) NOT NULL,
  `id_estudiante` int(11) NOT NULL,
  `mes_anio` date NOT NULL,
  `monto_beca` decimal(10,2) NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `estado` enum('Pendiente','Pagado','Cancelado') DEFAULT 'Pendiente',
  `observaciones` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_beca`
--

CREATE TABLE `tipos_beca` (
  `id_tipo_beca` int(11) NOT NULL,
  `nombre_beca` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipos_beca`
--

INSERT INTO `tipos_beca` (`id_tipo_beca`, `nombre_beca`, `descripcion`) VALUES
(1, 'Beca Deportiva', 'Beca asignada por méritos deportivos'),
(2, 'Beca Académica', 'Beca asignada por excelencia académica'),
(3, 'Beca Administrativa', 'Beca por trabajo administrativo'),
(4, 'Beca de Preparador', 'Beca por labores de preparación académica');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id_departamento`),
  ADD UNIQUE KEY `nombre_departamento` (`nombre_departamento`);

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`id_estudiante`),
  ADD UNIQUE KEY `cedula` (`cedula`),
  ADD KEY `id_tipo_beca` (`id_tipo_beca`),
  ADD KEY `idx_estudiante_activo` (`activo`);

--
-- Indices de la tabla `estudiante_departamento`
--
ALTER TABLE `estudiante_departamento`
  ADD PRIMARY KEY (`id_relacion`),
  ADD UNIQUE KEY `unique_estudiante_departamento` (`id_estudiante`,`id_departamento`),
  ADD KEY `id_departamento` (`id_departamento`),
  ADD KEY `idx_estudiante_departamento_activo` (`activo`);

--
-- Indices de la tabla `registros_beca`
--
ALTER TABLE `registros_beca`
  ADD PRIMARY KEY (`id_registro`),
  ADD UNIQUE KEY `unique_estudiante_mes` (`id_estudiante`,`mes_anio`),
  ADD KEY `idx_registros_mes` (`mes_anio`),
  ADD KEY `idx_registros_estado` (`estado`);

--
-- Indices de la tabla `tipos_beca`
--
ALTER TABLE `tipos_beca`
  ADD PRIMARY KEY (`id_tipo_beca`),
  ADD UNIQUE KEY `nombre_beca` (`nombre_beca`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id_departamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  MODIFY `id_estudiante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estudiante_departamento`
--
ALTER TABLE `estudiante_departamento`
  MODIFY `id_relacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registros_beca`
--
ALTER TABLE `registros_beca`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipos_beca`
--
ALTER TABLE `tipos_beca`
  MODIFY `id_tipo_beca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD CONSTRAINT `estudiantes_ibfk_1` FOREIGN KEY (`id_tipo_beca`) REFERENCES `tipos_beca` (`id_tipo_beca`);

--
-- Filtros para la tabla `estudiante_departamento`
--
ALTER TABLE `estudiante_departamento`
  ADD CONSTRAINT `estudiante_departamento_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`),
  ADD CONSTRAINT `estudiante_departamento_ibfk_2` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`);

--
-- Filtros para la tabla `registros_beca`
--
ALTER TABLE `registros_beca`
  ADD CONSTRAINT `registros_beca_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
