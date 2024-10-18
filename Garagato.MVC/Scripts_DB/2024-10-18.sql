-- Crear la base de datos
CREATE DATABASE [GaragatoDatabase];
GO

-- Usar la base de datos recién creada
USE [GaragatoDatabase];
GO

-- Configuración inicial
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

-- Crear la tabla Usuario
CREATE TABLE [dbo].[Usuario] (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Nombre] NVARCHAR(50) NOT NULL,
    [Mail] NVARCHAR(50) NOT NULL,
    [Contrasena] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED ([Id] ASC)
) ON [PRIMARY];
GO

-- Crear la tabla Sala
CREATE TABLE [dbo].[Sala] (
    SalaID INT PRIMARY KEY IDENTITY(1,1),
    NombreSala NVARCHAR(50) NOT NULL,
    CreadorSala NVARCHAR(50) NOT NULL
);
GO

-- Crear la tabla Palabra
CREATE TABLE [dbo].[Palabra] (
    PalabraID INT PRIMARY KEY IDENTITY(1,1),
    Palabra NVARCHAR(100) NOT NULL
);
GO

-- Crear la tabla intermedia UsuarioSala para la relación muchos a muchos
CREATE TABLE [dbo].[UsuarioSala] (
    UsuarioSalaID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT NOT NULL,
    SalaID INT NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES [dbo].[Usuario](Id),
    FOREIGN KEY (SalaID) REFERENCES [dbo].[Sala](SalaID)
);
GO

-- Crear la tabla Puntuacion
CREATE TABLE [dbo].[Puntuacion] (
    PuntuacionID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT NOT NULL,
    SalaID INT NOT NULL,
    Puntuacion INT NOT NULL DEFAULT 0, -- Establece el valor predeterminado a 0
    FOREIGN KEY (UsuarioID) REFERENCES [dbo].[Usuario](Id),
    FOREIGN KEY (SalaID) REFERENCES [dbo].[Sala](SalaID)
);
GO

-- Insertar datos en la tabla Usuario
INSERT INTO [dbo].[Usuario] (Nombre, Mail, Contrasena) VALUES
('Juan Pérez', 'juan.perez@example.com', 'contraseña123'),
('Ana Gómez', 'ana.gomez@example.com', 'contraseña456'),
('Luis Fernández', 'luis.fernandez@example.com', 'contraseña789'),
('María López', 'maria.lopez@example.com', 'contraseña101'),
('Carlos Sánchez', 'carlos.sanchez@example.com', 'contraseña202');
GO

-- Insertar datos en la tabla Sala
INSERT INTO [dbo].[Sala] (NombreSala, CreadorSala) VALUES
('Sala de Mati', 'Juan Pérez'),
('Sala de Alan', 'Ana Gómez'),
('Sala de May', 'Luis Fernández'),
('Sala de Pablo', 'María López'),
('Sala de Orne', 'Carlos Sánchez'),
('Sala de Ivone', 'Luis Fernández'),
('Sala de Rama', 'Ana Gómez');
GO

-- Insertar datos en la tabla Palabra
INSERT INTO [dbo].[Palabra] (Palabra) VALUES
('Pelota'),
('Libro'),
('Fuego'),
('Isla'),
('Gato');
GO

-- Insertar datos en la tabla intermedia UsuarioSala
INSERT INTO [dbo].[UsuarioSala] (UsuarioID, SalaID) VALUES
(1, 1), 
(2, 1), 
(3, 3),
(4, 2),  
(5, 4);
GO

-- Insertar datos en la tabla Puntuacion
INSERT INTO [dbo].[Puntuacion] (UsuarioID, SalaID, Puntuacion) VALUES
(1, 1, 5), 
(2, 1, 3),  
(3, 3, 4),  
(4, 2, 5), 
(5, 4, 2);
GO