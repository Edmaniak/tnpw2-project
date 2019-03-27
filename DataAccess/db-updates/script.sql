USE [master]
GO
/****** Object:  Database [tnpw_eam]    Script Date: 27.03.2019 16:34:48 ******/
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
/****** Object:  Schema [new_schema]    Script Date: 27.03.2019 16:34:49 ******/
CREATE SCHEMA [new_schema]
GO
/****** Object:  Table [dbo].[address__address]    Script Date: 27.03.2019 16:34:49 ******/
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
/****** Object:  Table [dbo].[bussiness__bussiness]    Script Date: 27.03.2019 16:34:49 ******/
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
/****** Object:  Table [dbo].[controls__category]    Script Date: 27.03.2019 16:34:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[controls__category](
                                         [id] [int] IDENTITY(1,1) NOT NULL,
                                         [title] [varchar](50) NULL,
                                         [description] [text] NOT NULL,
                                         [deletable] [smallint] NOT NULL,
                                         CONSTRAINT [PK_controls__category] PRIMARY KEY CLUSTERED
                                           (
                                            [id] ASC
                                             )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[controls__control]    Script Date: 27.03.2019 16:34:50 ******/
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
/****** Object:  Table [dbo].[controls__status]    Script Date: 27.03.2019 16:34:50 ******/
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
/****** Object:  Table [dbo].[environments__category]    Script Date: 27.03.2019 16:34:50 ******/
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
/****** Object:  Table [dbo].[environments__environment]    Script Date: 27.03.2019 16:34:50 ******/
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
/****** Object:  Table [dbo].[equipments__category]    Script Date: 27.03.2019 16:34:50 ******/
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
/****** Object:  Table [dbo].[equipments__equipment]    Script Date: 27.03.2019 16:34:50 ******/
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
/****** Object:  Table [dbo].[equipments__status]    Script Date: 27.03.2019 16:34:50 ******/
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
/****** Object:  Table [dbo].[rooms__category]    Script Date: 27.03.2019 16:34:51 ******/
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
/****** Object:  Table [dbo].[rooms__room]    Script Date: 27.03.2019 16:34:51 ******/
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
/****** Object:  Table [dbo].[tickets__category]    Script Date: 27.03.2019 16:34:51 ******/
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
/****** Object:  Table [dbo].[tickets__status]    Script Date: 27.03.2019 16:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tickets__status](
                                      [id] [int] IDENTITY(1,1) NOT NULL,
                                      [title] [varchar](100) NOT NULL,
                                      [description] [text] NULL,
                                      [deletable] [smallint] NOT NULL,
                                      [color_class] [varchar](50) NOT NULL,
                                      CONSTRAINT [PK_tickets__status] PRIMARY KEY CLUSTERED
                                        (
                                         [id] ASC
                                          )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tickets__ticket]    Script Date: 27.03.2019 16:34:51 ******/
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
/****** Object:  Table [dbo].[users__role]    Script Date: 27.03.2019 16:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users__role](
                                  [id] [int] IDENTITY(1,1) NOT NULL,
                                  [title] [varchar](255) NULL,
                                  [description] [varchar](255) NULL,
                                  CONSTRAINT [users__role_pk] PRIMARY KEY NONCLUSTERED
                                    (
                                     [id] ASC
                                      )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users__user]    Script Date: 27.03.2019 16:34:51 ******/
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
                                  CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED
                                    (
                                     [id] ASC
                                      )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
  REFERENCES [dbo].[users__role] ([id])
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
