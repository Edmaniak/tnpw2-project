USE [master]
GO
/****** Object:  Database [tnpw_eam]    Script Date: 08.04.2019 12:06:49 ******/
CREATE DATABASE [tnpw_eam]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tnpw_eam', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tnpw_eam.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'tnpw_eam_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tnpw_eam_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [tnpw_eam] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [tnpw_eam].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [tnpw_eam] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [tnpw_eam] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [tnpw_eam] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [tnpw_eam] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [tnpw_eam] SET ARITHABORT OFF 
GO
ALTER DATABASE [tnpw_eam] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [tnpw_eam] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [tnpw_eam] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [tnpw_eam] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [tnpw_eam] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [tnpw_eam] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [tnpw_eam] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [tnpw_eam] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [tnpw_eam] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [tnpw_eam] SET  DISABLE_BROKER 
GO
ALTER DATABASE [tnpw_eam] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [tnpw_eam] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [tnpw_eam] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [tnpw_eam] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [tnpw_eam] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [tnpw_eam] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [tnpw_eam] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [tnpw_eam] SET RECOVERY FULL 
GO
ALTER DATABASE [tnpw_eam] SET  MULTI_USER 
GO
ALTER DATABASE [tnpw_eam] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [tnpw_eam] SET DB_CHAINING OFF 
GO
ALTER DATABASE [tnpw_eam] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [tnpw_eam] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [tnpw_eam] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'tnpw_eam', N'ON'
GO
ALTER DATABASE [tnpw_eam] SET QUERY_STORE = OFF
GO
USE [tnpw_eam]
GO
/****** Object:  Schema [new_schema]    Script Date: 08.04.2019 12:06:50 ******/
CREATE SCHEMA [new_schema]
GO
/****** Object:  Table [dbo].[address__address]    Script Date: 08.04.2019 12:06:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address__address](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[zip] [int] NULL,
	[street] [varchar](255) NULL,
	[city] [varchar](255) NULL,
	[state] [varchar](255) NULL,
 CONSTRAINT [PK_address__address] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bussiness__bussiness]    Script Date: 08.04.2019 12:06:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bussiness__bussiness](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[description] [text] NULL,
	[address_id] [int] NOT NULL,
 CONSTRAINT [PK_bussiness__bussiness] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[controls__category]    Script Date: 08.04.2019 12:06:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[controls__category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NULL,
	[description] [text] NULL,
	[deletable] [smallint] NOT NULL,
 CONSTRAINT [PK_controls__category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[controls__control]    Script Date: 08.04.2019 12:06:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[controls__control](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NOT NULL,
	[description] [text] NOT NULL,
	[date_performed] [datetime] NULL,
	[date_planned] [datetime] NULL,
	[user_to_perform_id] [int] NULL,
	[equipment_id] [int] NULL,
	[user_performed_id] [int] NULL,
	[user_planned_id] [int] NULL,
	[priority] [int] NULL,
	[status_id] [int] NULL,
	[category_id] [int] NULL,
 CONSTRAINT [PK_controls__control] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[controls__status]    Script Date: 08.04.2019 12:06:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[controls__status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](100) NOT NULL,
	[description] [text] NULL,
	[deletable] [smallint] NOT NULL,
 CONSTRAINT [PK_controls__control_status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[environments__category]    Script Date: 08.04.2019 12:06:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[environments__category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NOT NULL,
	[description] [text] NOT NULL,
	[deletable] [smallint] NOT NULL,
 CONSTRAINT [PK_environments__environment_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[environments__environment]    Script Date: 08.04.2019 12:06:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[environments__environment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[description] [text] NULL,
	[bussiness_id] [int] NULL,
	[address_id] [int] NULL,
	[category_id] [int] NULL,
	[code] [varchar](50) NOT NULL,
 CONSTRAINT [PK_environments__environment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[equipments__category]    Script Date: 08.04.2019 12:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[equipments__category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NOT NULL,
	[description] [text] NOT NULL,
	[deletable] [smallint] NOT NULL,
 CONSTRAINT [PK_equipments__equipment_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[equipments__equipment]    Script Date: 08.04.2019 12:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[equipments__equipment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NOT NULL,
	[description] [text] NULL,
	[purchased] [datetime] NOT NULL,
	[warranty] [datetime] NOT NULL,
	[status_id] [int] NULL,
	[room_id] [int] NULL,
	[category_id] [int] NULL,
	[code] [varchar](50) NULL,
 CONSTRAINT [PK_equipments__equipment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[equipments__status]    Script Date: 08.04.2019 12:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[equipments__status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NOT NULL,
	[description] [text] NULL,
	[deletable] [smallint] NOT NULL,
 CONSTRAINT [PK_equipments__status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rooms__category]    Script Date: 08.04.2019 12:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rooms__category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NOT NULL,
	[description] [text] NULL,
	[deletable] [smallint] NULL,
 CONSTRAINT [PK_rooms__room_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rooms__room]    Script Date: 08.04.2019 12:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rooms__room](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[purpouse] [text] NOT NULL,
	[code] [varchar](50) NOT NULL,
	[floor] [int] NOT NULL,
	[environment_id] [int] NULL,
	[category_id] [int] NULL,
 CONSTRAINT [PK_rooms_room] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tickets__category]    Script Date: 08.04.2019 12:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tickets__category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NULL,
	[description] [text] NULL,
	[color_class] [varchar](50) NULL,
	[deletable] [smallint] NOT NULL,
	[impact] [int] NULL,
 CONSTRAINT [PK_tickets__ticket_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tickets__status]    Script Date: 08.04.2019 12:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tickets__status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](100) NOT NULL,
	[description] [text] NULL,
	[deletable] [smallint] NOT NULL,
	[color_class] [varchar](50) NULL,
 CONSTRAINT [PK_tickets__status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tickets__ticket]    Script Date: 08.04.2019 12:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tickets__ticket](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NOT NULL,
	[description] [text] NOT NULL,
	[equipment_id] [int] NULL,
	[author_id] [int] NULL,
	[solver_id] [int] NULL,
	[assigned_id] [int] NULL,
	[status_id] [int] NULL,
	[category_id] [int] NULL,
	[created] [datetime] NOT NULL,
	[deadline] [datetime] NULL,
 CONSTRAINT [PK_tickets__problem_ticket] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users__role]    Script Date: 08.04.2019 12:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users__role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NULL,
	[description] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users__user]    Script Date: 08.04.2019 12:06:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users__user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[surname] [varchar](255) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[role_id] [int] NOT NULL,
	[phone] [varchar](255) NOT NULL,
	[address_id] [int] NULL,
	[deletable] [smallint] NOT NULL,
	[profession] [varchar](100) NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[address__address] ON 
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (1, 51202, N'Drakova 1', N'Hradec Králové', N'Czech Republic')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (3, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (4, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (5, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (6, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (1006, 51200, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (1008, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2002, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2003, 51200, N'K Zahradě 12', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2004, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2005, 51200, N'K Zahradě 12', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2011, 51200, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2012, 51200, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2013, 512000, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2014, 512000, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2015, 512000, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2016, 512000, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2017, 512000, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2018, 512000, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2019, 512000, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2020, 512000, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2021, 512000, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2022, 512000, N'K Lopatě', N'Hradec Královée', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2023, 512000, N'K Lopatě', N'Hradec Královée', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2024, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2025, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2026, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2027, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2028, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2029, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2030, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2031, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2032, 51200, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2033, 51200, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2034, 51200, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2035, 51200, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2036, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2037, 51200, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2038, 51200, N'K Lopatě', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2039, 51200, N'K Zahradě 12', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2040, 51200, N'K Zahradě 5', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2041, 51200, N'K Zahradě 6', N'Hradec Králové', N'CR')
GO
INSERT [dbo].[address__address] ([id], [zip], [street], [city], [state]) VALUES (2042, 51200, N'K Zahradě 6', N'Hradec Králové', N'CR')
GO
SET IDENTITY_INSERT [dbo].[address__address] OFF
GO
SET IDENTITY_INSERT [dbo].[controls__category] ON 
GO
INSERT [dbo].[controls__category] ([id], [title], [description], [deletable]) VALUES (1, N'Nekategorizováno', N'Kontrola není nijak kategorizovaná', 0)
GO
INSERT [dbo].[controls__category] ([id], [title], [description], [deletable]) VALUES (3, N'Povinná záruční kontrola', N'Kontrola podmíněná záručními podmínkami', 1)
GO
INSERT [dbo].[controls__category] ([id], [title], [description], [deletable]) VALUES (4, N'Preventivní kontrola', N'Preventivní kontrola (náhodná)', 1)
GO
SET IDENTITY_INSERT [dbo].[controls__category] OFF
GO
SET IDENTITY_INSERT [dbo].[controls__control] ON 
GO
INSERT [dbo].[controls__control] ([id], [title], [description], [date_performed], [date_planned], [user_to_perform_id], [equipment_id], [user_performed_id], [user_planned_id], [priority], [status_id], [category_id]) VALUES (1, N'Kontrola kotel pro zaruku', N'gfgdf', NULL, CAST(N'2019-04-18T00:00:00.000' AS DateTime), 3003, 5, NULL, NULL, NULL, 5, 1)
GO
INSERT [dbo].[controls__control] ([id], [title], [description], [date_performed], [date_planned], [user_to_perform_id], [equipment_id], [user_performed_id], [user_planned_id], [priority], [status_id], [category_id]) VALUES (2, N'Kontrola integrity', N'kk', NULL, CAST(N'2019-01-01T00:00:00.000' AS DateTime), 3003, 5, NULL, NULL, NULL, 2, 1)
GO
INSERT [dbo].[controls__control] ([id], [title], [description], [date_performed], [date_planned], [user_to_perform_id], [equipment_id], [user_performed_id], [user_planned_id], [priority], [status_id], [category_id]) VALUES (3, N'Testovaci kontrola', N'fds', NULL, CAST(N'2019-04-13T00:00:00.000' AS DateTime), 1, 5, NULL, NULL, NULL, 2, 1)
GO
INSERT [dbo].[controls__control] ([id], [title], [description], [date_performed], [date_planned], [user_to_perform_id], [equipment_id], [user_performed_id], [user_planned_id], [priority], [status_id], [category_id]) VALUES (6, N'Test equip', N'fff', NULL, CAST(N'2019-04-02T00:00:00.000' AS DateTime), 1, 6, NULL, NULL, NULL, 2, 3)
GO
SET IDENTITY_INSERT [dbo].[controls__control] OFF
GO
SET IDENTITY_INSERT [dbo].[controls__status] ON 
GO
INSERT [dbo].[controls__status] ([id], [title], [description], [deletable]) VALUES (1, N'Nekategorizováno', N'Kontrola není nijak kategorizovaná', 0)
GO
INSERT [dbo].[controls__status] ([id], [title], [description], [deletable]) VALUES (2, N'Naplánováno', N'Kontrola je naplánována', 0)
GO
INSERT [dbo].[controls__status] ([id], [title], [description], [deletable]) VALUES (3, N'Právě prováděno', N'Kontrola se právě provádí (horizont jednoho až tří dnů)', 1)
GO
INSERT [dbo].[controls__status] ([id], [title], [description], [deletable]) VALUES (4, N'Provedeno', N'Kontrola byla provedena', 1)
GO
INSERT [dbo].[controls__status] ([id], [title], [description], [deletable]) VALUES (5, N'Archivováno', N'Záznam o kontrole byl archivován', 0)
GO
SET IDENTITY_INSERT [dbo].[controls__status] OFF
GO
SET IDENTITY_INSERT [dbo].[environments__category] ON 
GO
INSERT [dbo].[environments__category] ([id], [title], [description], [deletable]) VALUES (1, N'Nekategorizováno', N'Prostředí není nijak kategorizovano', 0)
GO
INSERT [dbo].[environments__category] ([id], [title], [description], [deletable]) VALUES (2, N'Budova', N'Klasická budova;jj;;', 1)
GO
INSERT [dbo].[environments__category] ([id], [title], [description], [deletable]) VALUES (3, N'Exteriér', N'Exteriér (pozemek)', 1)
GO
INSERT [dbo].[environments__category] ([id], [title], [description], [deletable]) VALUES (4, N'Sportoviště', N'Prostředí sportoviště', 1)
GO
SET IDENTITY_INSERT [dbo].[environments__category] OFF
GO
SET IDENTITY_INSERT [dbo].[environments__environment] ON 
GO
INSERT [dbo].[environments__environment] ([id], [name], [description], [bussiness_id], [address_id], [category_id], [code]) VALUES (2, N'Skladiště 1234', N'12456', NULL, 2023, 2, N'1C')
GO
INSERT [dbo].[environments__environment] ([id], [name], [description], [bussiness_id], [address_id], [category_id], [code]) VALUES (4, N'Výrobní hala 2', N'gfds', NULL, 2042, 2, N'gfds')
GO
INSERT [dbo].[environments__environment] ([id], [name], [description], [bussiness_id], [address_id], [category_id], [code]) VALUES (1009, N'Filozofická fakulta', N'Pro filosofy', NULL, 2030, 2, N'123')
GO
SET IDENTITY_INSERT [dbo].[environments__environment] OFF
GO
SET IDENTITY_INSERT [dbo].[equipments__category] ON 
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (3, N'Nekategorizováno', N'Vybavení není nijak kategorizovano', 0)
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (4, N'Elektronika', N'Elektronické vybavení', 1)
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (5, N'Nábytek', N'Obecně všechno (židle, stoly)', 1)
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (6, N'Dekorace', N'Dekorace', 1)
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (7, N'Osvětlení', N'Světla na chodbách a jiné', 1)
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (8, N'Krytiny', N'Koberce, parkety atd.', 1)
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (9, N'Rozvody', N'Technické věci kolem rozvodů vody, elektroniky a plynu', 1)
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (10, N'Vodovodní zařízení', N'Technické věci kolem distribuce vody', 1)
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (11, N'Sanitární zařízení', N'WC, umyvadla ...', 1)
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (12, N'Topná zařízení', N'Kotle, rozvody plynu...', 1)
GO
INSERT [dbo].[equipments__category] ([id], [title], [description], [deletable]) VALUES (13, N'Okna a dveře', N'Okna a dveře', 1)
GO
SET IDENTITY_INSERT [dbo].[equipments__category] OFF
GO
SET IDENTITY_INSERT [dbo].[equipments__equipment] ON 
GO
INSERT [dbo].[equipments__equipment] ([id], [title], [description], [purchased], [warranty], [status_id], [room_id], [category_id], [code]) VALUES (5, N'Kotel', N'fdfd', CAST(N'2019-03-13T00:00:00.000' AS DateTime), CAST(N'2019-03-27T00:00:00.000' AS DateTime), 1, 5, 3, N'fdf')
GO
INSERT [dbo].[equipments__equipment] ([id], [title], [description], [purchased], [warranty], [status_id], [room_id], [category_id], [code]) VALUES (6, N'PC-2', N'Pc nainstalovany windows', CAST(N'2019-01-03T00:00:00.000' AS DateTime), CAST(N'2019-02-03T00:00:00.000' AS DateTime), 2, 5, 5, N'123')
GO
SET IDENTITY_INSERT [dbo].[equipments__equipment] OFF
GO
SET IDENTITY_INSERT [dbo].[equipments__status] ON 
GO
INSERT [dbo].[equipments__status] ([id], [title], [description], [deletable]) VALUES (1, N'Nekategorizováno', N'Stav není nijak kategorizovan', 0)
GO
INSERT [dbo].[equipments__status] ([id], [title], [description], [deletable]) VALUES (2, N'Funkční', N'Zařízení je plně funkční', 0)
GO
INSERT [dbo].[equipments__status] ([id], [title], [description], [deletable]) VALUES (3, N'Rozbité (problém se řeší)', N'Zařízení je rozbité a jeho napravení je aktuálně přiděleno nějakému opraváři', 0)
GO
INSERT [dbo].[equipments__status] ([id], [title], [description], [deletable]) VALUES (4, N'Rozbité (problém se zatím neřeší)', N'Zařízení je rozbité, ale zatím se k tomu nikdo nedostal', 0)
GO
INSERT [dbo].[equipments__status] ([id], [title], [description], [deletable]) VALUES (5, N'Uskladněno', N'Vybavení se nepoužívá a je uskladněno', 1)
GO
SET IDENTITY_INSERT [dbo].[equipments__status] OFF
GO
SET IDENTITY_INSERT [dbo].[rooms__category] ON 
GO
INSERT [dbo].[rooms__category] ([id], [title], [description], [deletable]) VALUES (1, N'Nekategorizováno', N'Místnost není nijak kategorizovana', 0)
GO
INSERT [dbo].[rooms__category] ([id], [title], [description], [deletable]) VALUES (2, N'Učebna', N'Místnost sloužící k výuce', 1)
GO
INSERT [dbo].[rooms__category] ([id], [title], [description], [deletable]) VALUES (3, N'Technické zázemí', N'Místnost pro technické zázemí', 1)
GO
INSERT [dbo].[rooms__category] ([id], [title], [description], [deletable]) VALUES (4, N'Kancelář', N'Místnost pro administrativní účely', 1)
GO
INSERT [dbo].[rooms__category] ([id], [title], [description], [deletable]) VALUES (5, N'Chodba', N'Chodba propojující další místnosti', 1)
GO
INSERT [dbo].[rooms__category] ([id], [title], [description], [deletable]) VALUES (6, N'Společné prostory', N'Místnost sloužící pro více lidí', 1)
GO
SET IDENTITY_INSERT [dbo].[rooms__category] OFF
GO
SET IDENTITY_INSERT [dbo].[rooms__room] ON 
GO
INSERT [dbo].[rooms__room] ([id], [name], [purpouse], [code], [floor], [environment_id], [category_id]) VALUES (4, N'J2', N'kk', N'k', 1, 4, 2)
GO
INSERT [dbo].[rooms__room] ([id], [name], [purpouse], [code], [floor], [environment_id], [category_id]) VALUES (5, N'J3', N'pp', N'oo', 1, 4, 2)
GO
INSERT [dbo].[rooms__room] ([id], [name], [purpouse], [code], [floor], [environment_id], [category_id]) VALUES (1005, N'Interiér', N'Interier skladiště', N'fdsa', 2, 4, 2)
GO
SET IDENTITY_INSERT [dbo].[rooms__room] OFF
GO
SET IDENTITY_INSERT [dbo].[tickets__category] ON 
GO
INSERT [dbo].[tickets__category] ([id], [title], [description], [color_class], [deletable], [impact]) VALUES (2, N'Nekategorizováno', N'Problém není nijak kategorizovan', N'info', 0, 0)
GO
INSERT [dbo].[tickets__category] ([id], [title], [description], [color_class], [deletable], [impact]) VALUES (3, N'Může počkat', N'O problému se ví, ale není třeba ho řešit v krátkodobém horizontu', N'success', 1, 10)
GO
INSERT [dbo].[tickets__category] ([id], [title], [description], [color_class], [deletable], [impact]) VALUES (4, N'Je třeba řešit', N'O problému se ví a je třeba ho řešit v krátkodobém horizontu', N'warning', 1, 20)
GO
INSERT [dbo].[tickets__category] ([id], [title], [description], [color_class], [deletable], [impact]) VALUES (5, N'Naléhavé', N'Problém je třeba vyřešit ihned!', N'danger', 1, 30)
GO
SET IDENTITY_INSERT [dbo].[tickets__category] OFF
GO
SET IDENTITY_INSERT [dbo].[tickets__status] ON 
GO
INSERT [dbo].[tickets__status] ([id], [title], [description], [deletable], [color_class]) VALUES (1, N'Řeší se', N'Problém je aktuálně řešen', 0, N'info')
GO
INSERT [dbo].[tickets__status] ([id], [title], [description], [deletable], [color_class]) VALUES (2, N'Řešení naplánováno a přiřazeno', N'Řešení problému je přiřazeno pracovníkovi', 0, N'primary')
GO
INSERT [dbo].[tickets__status] ([id], [title], [description], [deletable], [color_class]) VALUES (3, N'Pouze zaznamenáno', N'O problému se ví, ale nikdo k němu nebyl přidělen', 0, N'warning')
GO
INSERT [dbo].[tickets__status] ([id], [title], [description], [deletable], [color_class]) VALUES (4, N'Vyřešeno', N'Problém byl vyřešen', 0, N'success')
GO
INSERT [dbo].[tickets__status] ([id], [title], [description], [deletable], [color_class]) VALUES (5, N'Archivováno', N'Záznam je archivován', 0, N'primary')
GO
SET IDENTITY_INSERT [dbo].[tickets__status] OFF
GO
SET IDENTITY_INSERT [dbo].[users__role] ON 
GO
INSERT [dbo].[users__role] ([id], [title], [description]) VALUES (1, N'admin', N'He has all the privililages and he can enter every section of the app')
GO
INSERT [dbo].[users__role] ([id], [title], [description]) VALUES (2, N'maintainer', N'Fixes things')
GO
INSERT [dbo].[users__role] ([id], [title], [description]) VALUES (3, N'manager', N'Manages')
GO
INSERT [dbo].[users__role] ([id], [title], [description]) VALUES (4, N'employee', N'Employee can add problems')
GO
SET IDENTITY_INSERT [dbo].[users__role] OFF
GO
SET IDENTITY_INSERT [dbo].[users__user] ON 
GO
INSERT [dbo].[users__user] ([id], [name], [surname], [password], [email], [role_id], [phone], [address_id], [deletable], [profession]) VALUES (1, N'Michal', N'Horák', N'123', N'horak@gmail.com', 2, N'4756423', 2036, 1, N'Dlaždič')
GO
INSERT [dbo].[users__user] ([id], [name], [surname], [password], [email], [role_id], [phone], [address_id], [deletable], [profession]) VALUES (3002, N'Jan', N'Horáček', N'123', N'horacek@gmail.com', 3, N'123456789', 2038, 1, N'Assets Manager')
GO
INSERT [dbo].[users__user] ([id], [name], [surname], [password], [email], [role_id], [phone], [address_id], [deletable], [profession]) VALUES (3003, N'Adam', N' Ouhrabka', N'930318', N'adam.ouhrabka@gmail.com', 1, N'4756423', 2034, 1, N'Správce systému')
GO
INSERT [dbo].[users__user] ([id], [name], [surname], [password], [email], [role_id], [phone], [address_id], [deletable], [profession]) VALUES (3005, N'Petr', N'Koza', N'123', N'koza@gmail.com', 4, N'123456789', 2039, 1, N'Zamestnanec')
GO
SET IDENTITY_INSERT [dbo].[users__user] OFF
GO
/****** Object:  Index [users__role_pk]    Script Date: 08.04.2019 12:06:51 ******/
ALTER TABLE [dbo].[users__role] ADD  CONSTRAINT [users__role_pk] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[controls__category] ADD  CONSTRAINT [DF_controls__category_deletable]  DEFAULT ((1)) FOR [deletable]
GO
ALTER TABLE [dbo].[controls__status] ADD  CONSTRAINT [DF_controls__status_deletable]  DEFAULT ((1)) FOR [deletable]
GO
ALTER TABLE [dbo].[environments__category] ADD  CONSTRAINT [DF_environments__category_deletable]  DEFAULT ((1)) FOR [deletable]
GO
ALTER TABLE [dbo].[equipments__category] ADD  CONSTRAINT [DF_equipments__category_deletable]  DEFAULT ((1)) FOR [deletable]
GO
ALTER TABLE [dbo].[equipments__status] ADD  CONSTRAINT [DF_equipments__status_deletable]  DEFAULT ((1)) FOR [deletable]
GO
ALTER TABLE [dbo].[rooms__category] ADD  CONSTRAINT [DF_rooms__category_deletable]  DEFAULT ((1)) FOR [deletable]
GO
ALTER TABLE [dbo].[tickets__category] ADD  CONSTRAINT [DF_tickets__category_deletable]  DEFAULT ((1)) FOR [deletable]
GO
ALTER TABLE [dbo].[tickets__status] ADD  CONSTRAINT [DF_tickets__status_deletable]  DEFAULT ((1)) FOR [deletable]
GO
ALTER TABLE [dbo].[users__user] ADD  CONSTRAINT [DF_users__user_deletable]  DEFAULT ((1)) FOR [deletable]
GO
ALTER TABLE [dbo].[bussiness__bussiness]  WITH CHECK ADD  CONSTRAINT [FK_bussiness__bussiness_address__address] FOREIGN KEY([address_id])
REFERENCES [dbo].[address__address] ([id])
GO
ALTER TABLE [dbo].[bussiness__bussiness] CHECK CONSTRAINT [FK_bussiness__bussiness_address__address]
GO
ALTER TABLE [dbo].[controls__control]  WITH CHECK ADD  CONSTRAINT [FK_controls__control_controls__category] FOREIGN KEY([category_id])
REFERENCES [dbo].[controls__category] ([id])
GO
ALTER TABLE [dbo].[controls__control] CHECK CONSTRAINT [FK_controls__control_controls__category]
GO
ALTER TABLE [dbo].[controls__control]  WITH CHECK ADD  CONSTRAINT [FK_controls__control_controls__status] FOREIGN KEY([status_id])
REFERENCES [dbo].[controls__status] ([id])
GO
ALTER TABLE [dbo].[controls__control] CHECK CONSTRAINT [FK_controls__control_controls__status]
GO
ALTER TABLE [dbo].[controls__control]  WITH CHECK ADD  CONSTRAINT [FK_controls__control_equipments__equipment] FOREIGN KEY([equipment_id])
REFERENCES [dbo].[equipments__equipment] ([id])
GO
ALTER TABLE [dbo].[controls__control] CHECK CONSTRAINT [FK_controls__control_equipments__equipment]
GO
ALTER TABLE [dbo].[controls__control]  WITH CHECK ADD  CONSTRAINT [FK_controls__control_users__user] FOREIGN KEY([user_performed_id])
REFERENCES [dbo].[users__user] ([id])
GO
ALTER TABLE [dbo].[controls__control] CHECK CONSTRAINT [FK_controls__control_users__user]
GO
ALTER TABLE [dbo].[controls__control]  WITH CHECK ADD  CONSTRAINT [FK_controls__control_users__user1] FOREIGN KEY([user_to_perform_id])
REFERENCES [dbo].[users__user] ([id])
GO
ALTER TABLE [dbo].[controls__control] CHECK CONSTRAINT [FK_controls__control_users__user1]
GO
ALTER TABLE [dbo].[controls__control]  WITH CHECK ADD  CONSTRAINT [FK_controls__control_users__usert] FOREIGN KEY([user_planned_id])
REFERENCES [dbo].[users__user] ([id])
GO
ALTER TABLE [dbo].[controls__control] CHECK CONSTRAINT [FK_controls__control_users__usert]
GO
ALTER TABLE [dbo].[environments__environment]  WITH CHECK ADD  CONSTRAINT [FK_environments__environment_address__address] FOREIGN KEY([address_id])
REFERENCES [dbo].[address__address] ([id])
GO
ALTER TABLE [dbo].[environments__environment] CHECK CONSTRAINT [FK_environments__environment_address__address]
GO
ALTER TABLE [dbo].[environments__environment]  WITH CHECK ADD  CONSTRAINT [FK_environments__environment_bussiness__bussiness] FOREIGN KEY([bussiness_id])
REFERENCES [dbo].[bussiness__bussiness] ([id])
GO
ALTER TABLE [dbo].[environments__environment] CHECK CONSTRAINT [FK_environments__environment_bussiness__bussiness]
GO
ALTER TABLE [dbo].[environments__environment]  WITH CHECK ADD  CONSTRAINT [FK_environments__environment_environments__environment_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[environments__category] ([id])
GO
ALTER TABLE [dbo].[environments__environment] CHECK CONSTRAINT [FK_environments__environment_environments__environment_category]
GO
ALTER TABLE [dbo].[equipments__equipment]  WITH CHECK ADD  CONSTRAINT [FK_equipments__equipment_address__address] FOREIGN KEY([room_id])
REFERENCES [dbo].[rooms__room] ([id])
GO
ALTER TABLE [dbo].[equipments__equipment] CHECK CONSTRAINT [FK_equipments__equipment_address__address]
GO
ALTER TABLE [dbo].[equipments__equipment]  WITH CHECK ADD  CONSTRAINT [FK_equipments__equipment_equipments__equipment_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[equipments__category] ([id])
GO
ALTER TABLE [dbo].[equipments__equipment] CHECK CONSTRAINT [FK_equipments__equipment_equipments__equipment_category]
GO
ALTER TABLE [dbo].[equipments__equipment]  WITH CHECK ADD  CONSTRAINT [FK_equipments__equipment_equipments__status] FOREIGN KEY([status_id])
REFERENCES [dbo].[equipments__status] ([id])
GO
ALTER TABLE [dbo].[equipments__equipment] CHECK CONSTRAINT [FK_equipments__equipment_equipments__status]
GO
ALTER TABLE [dbo].[rooms__room]  WITH CHECK ADD  CONSTRAINT [FK_rooms_room_environments__environment] FOREIGN KEY([environment_id])
REFERENCES [dbo].[environments__environment] ([id])
GO
ALTER TABLE [dbo].[rooms__room] CHECK CONSTRAINT [FK_rooms_room_environments__environment]
GO
ALTER TABLE [dbo].[rooms__room]  WITH CHECK ADD  CONSTRAINT [FK_rooms_room_rooms__room_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[rooms__category] ([id])
GO
ALTER TABLE [dbo].[rooms__room] CHECK CONSTRAINT [FK_rooms_room_rooms__room_category]
GO
ALTER TABLE [dbo].[tickets__ticket]  WITH CHECK ADD  CONSTRAINT [FK_tickets__problem_ticket_tickets__problem_ticket] FOREIGN KEY([assigned_id])
REFERENCES [dbo].[users__user] ([id])
GO
ALTER TABLE [dbo].[tickets__ticket] CHECK CONSTRAINT [FK_tickets__problem_ticket_tickets__problem_ticket]
GO
ALTER TABLE [dbo].[tickets__ticket]  WITH CHECK ADD  CONSTRAINT [FK_tickets__problem_ticket_users__user] FOREIGN KEY([author_id])
REFERENCES [dbo].[users__user] ([id])
GO
ALTER TABLE [dbo].[tickets__ticket] CHECK CONSTRAINT [FK_tickets__problem_ticket_users__user]
GO
ALTER TABLE [dbo].[tickets__ticket]  WITH CHECK ADD  CONSTRAINT [FK_tickets__problem_ticket_users__user1] FOREIGN KEY([solver_id])
REFERENCES [dbo].[users__user] ([id])
GO
ALTER TABLE [dbo].[tickets__ticket] CHECK CONSTRAINT [FK_tickets__problem_ticket_users__user1]
GO
ALTER TABLE [dbo].[tickets__ticket]  WITH CHECK ADD  CONSTRAINT [FK_tickets__ticket_equipments__equipment] FOREIGN KEY([equipment_id])
REFERENCES [dbo].[equipments__equipment] ([id])
GO
ALTER TABLE [dbo].[tickets__ticket] CHECK CONSTRAINT [FK_tickets__ticket_equipments__equipment]
GO
ALTER TABLE [dbo].[tickets__ticket]  WITH CHECK ADD  CONSTRAINT [FK_tickets__ticket_tickets__category] FOREIGN KEY([category_id])
REFERENCES [dbo].[tickets__category] ([id])
GO
ALTER TABLE [dbo].[tickets__ticket] CHECK CONSTRAINT [FK_tickets__ticket_tickets__category]
GO
ALTER TABLE [dbo].[tickets__ticket]  WITH CHECK ADD  CONSTRAINT [FK_tickets__ticket_tickets__status] FOREIGN KEY([status_id])
REFERENCES [dbo].[tickets__status] ([id])
GO
ALTER TABLE [dbo].[tickets__ticket] CHECK CONSTRAINT [FK_tickets__ticket_tickets__status]
GO
ALTER TABLE [dbo].[users__user]  WITH CHECK ADD  CONSTRAINT [FK_users__user_address__address] FOREIGN KEY([address_id])
REFERENCES [dbo].[address__address] ([id])
GO
ALTER TABLE [dbo].[users__user] CHECK CONSTRAINT [FK_users__user_address__address]
GO
ALTER TABLE [dbo].[users__user]  WITH CHECK ADD  CONSTRAINT [FK_users__user_users__role] FOREIGN KEY([role_id])
REFERENCES [dbo].[users__role] ([id])
GO
ALTER TABLE [dbo].[users__user] CHECK CONSTRAINT [FK_users__user_users__role]
GO
USE [master]
GO
ALTER DATABASE [tnpw_eam] SET  READ_WRITE 
GO
