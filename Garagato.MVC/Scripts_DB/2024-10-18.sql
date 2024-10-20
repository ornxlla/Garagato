USE [master]
GO
/****** Object:  Database [GaragatoDatabase]    Script Date: 20/10/2024 13:15:51 ******/
-- Crear la base de datos
CREATE DATABASE [GaragatoDatabase]
ON PRIMARY 
(
    NAME = N'GaragatoDatabase', 
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\GaragatoDatabase.mdf', 
    SIZE = 5MB,    -- Tamaño inicial pequeño para mayor velocidad de creación
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 10MB -- Crecimiento en pasos de 10MB
)
LOG ON 
(
    NAME = N'GaragatoDatabase_log', 
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\GaragatoDatabase_log.ldf', 
    SIZE = 1MB,    -- Tamaño inicial del log pequeño
    MAXSIZE = 2048GB, 
    FILEGROWTH = 10MB -- Crecimiento del log en pasos de 10MB
)
GO

-- Establecer nivel de compatibilidad
ALTER DATABASE [GaragatoDatabase] SET COMPATIBILITY_LEVEL = 150
GO

-- Configuración adicional de la base de datos para rendimiento
ALTER DATABASE [GaragatoDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GaragatoDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GaragatoDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GaragatoDatabase] SET MULTI_USER 
GO
ALTER DATABASE [GaragatoDatabase] SET PAGE_VERIFY CHECKSUM  
GO

-- Usar la nueva base de datos
USE [GaragatoDatabase]
GO

/****** Object:  Table [dbo].[Palabra]    Script Date: 20/10/2024 13:15:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Palabra](
	[PalabraID] [int] IDENTITY(1,1) NOT NULL,
	[Palabra] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PalabraID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Puntuacion]    Script Date: 20/10/2024 13:15:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Puntuacion](
	[PuntuacionID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[SalaID] [int] NOT NULL,
	[Puntos] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PuntuacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sala]    Script Date: 20/10/2024 13:15:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sala](
	[SalaID] [int] IDENTITY(1,1) NOT NULL,
	[NombreSala] [nvarchar](50) NOT NULL,
	[CreadorSala] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 20/10/2024 13:15:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Mail] [nvarchar](50) NOT NULL,
	[Contrasena] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioSala]    Script Date: 20/10/2024 13:15:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioSala](
	[UsuarioSalaID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[SalaID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioSalaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Puntuacion] ADD  DEFAULT ((0)) FOR [Puntos]
GO
ALTER TABLE [dbo].[Puntuacion]  WITH CHECK ADD FOREIGN KEY([SalaID])
REFERENCES [dbo].[Sala] ([SalaID])
GO
ALTER TABLE [dbo].[Puntuacion]  WITH CHECK ADD FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuario] ([Id])
GO
ALTER TABLE [dbo].[UsuarioSala]  WITH CHECK ADD FOREIGN KEY([SalaID])
REFERENCES [dbo].[Sala] ([SalaID])
GO
ALTER TABLE [dbo].[UsuarioSala]  WITH CHECK ADD FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuario] ([Id])
GO
USE [master]
GO
ALTER DATABASE [GaragatoDatabase] SET  READ_WRITE 
GO