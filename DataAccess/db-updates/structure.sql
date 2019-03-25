create database tnpw_eam collate Czech_CI_AS
go

drop table controls__control
go

drop table controls__control_status
go

drop table environments__category
go

drop table equipments__equipment
go

drop table equipments__category
go

drop table equipments__status
go

drop table rooms__category
go

drop table rooms__room
go

drop table environments__environment
go

drop table bussiness__bussiness
go

drop table sysdiagrams
go

drop table tickets__category
go

drop table tickets__status
go

drop table tickets__ticket
go

drop table users__user
go

drop table address__address
go

drop table users__role
go

drop function fn_diagramobjects
go

drop procedure sp_alterdiagram
go

drop procedure sp_creatediagram
go

drop procedure sp_dropdiagram
go

drop procedure sp_helpdiagramdefinition
go

drop procedure sp_helpdiagrams
go

drop procedure sp_renamediagram
go

drop procedure sp_upgraddiagrams
go

drop database tnpw_eam
go



create table address__address
(
  id     int identity
    constraint PK_address__address
      primary key,
  zip    int,
  street varchar(255),
  city   varchar(255),
  state  varchar(255)
)
go

create table bussiness__bussiness
(
  id          int identity
    constraint PK_bussiness__bussiness
      primary key,
  name        varchar(255) not null,
  description text,
  address_id  int          not null
    constraint FK_bussiness__bussiness_address__address
      references address__address
)
go

create table controls__control_status
(
  id          int identity
    constraint PK_controls__control_status
      primary key,
  title       varchar(100) not null,
  description text
)
go

create table environments__category
(
  id          int identity
    constraint PK_environments__environment_category
      primary key,
  title       varchar(255) not null,
  description text         not null
)
go

create table environments__environment
(
  id           int identity
    constraint PK_environments__environment
      primary key,
  name         varchar(255) not null,
  description  text,
  bussiness_id int
    constraint FK_environments__environment_bussiness__bussiness
      references bussiness__bussiness,
  address_id   int
    constraint FK_environments__environment_address__address
      references address__address,
  category_id  int
    constraint FK_environments__environment_environments__environment_category
      references environments__environment_category (id),
  code         varchar(50)  not null
)
go

create table equipments__category
(
  id          int identity
    constraint PK_equipments__equipment_category
      primary key,
  title       varchar(255) not null,
  description text         not null
)
go

create table equipments__status
(
  id          int identity
    constraint PK_equipments__status
      primary key,
  title       varchar(255) not null,
  description text
)
go

create table rooms__category
(
  id          int identity
    constraint PK_rooms__room_category
      primary key,
  title       varchar(255) not null,
  description text         not null
)
go

create table rooms__room
(
  id             int identity
    constraint PK_rooms_room
      primary key,
  name           varchar(255) not null,
  purpouse       text         not null,
  code           varchar(50)  not null,
  floor          int          not null,
  environment_id int
    constraint FK_rooms_room_environments__environment
      references environments__environment,
  category_id    int
    constraint FK_rooms_room_rooms__room_category
      references rooms__room_category (id)
)
go

create table equipments__equipment
(
  id           int identity
    constraint PK_equipments__equipment
      primary key,
  title        varchar(255) not null,
  description  text,
  purchased    datetime     not null,
  warranty     datetime     not null,
  [status _id] int
    constraint FK_equipments__equipment_equipments__status
      references equipments__status,
  room_id      int
    constraint FK_equipments__equipment_address__address
      references rooms__room,
  category_id  int
    constraint FK_equipments__equipment_equipments__equipment_category
      references equipments__category,
  code         varchar(50)
)
go

create table sysdiagrams
(
  name         sysname not null,
  principal_id int     not null,
  diagram_id   int identity
    primary key,
  version      int,
  definition   varbinary(max),
  constraint UK_principal_name
    unique (principal_id, name)
)
go

create table tickets__category
(
  id          int not null
    constraint PK_tickets__ticket_category
      primary key,
  title       varchar(255),
  description text,
  color_class varchar(50)
)
go

create table tickets__status
(
  id          int identity
    constraint PK_tickets__status
      primary key,
  title       varchar(100) not null,
  description text
)
go

create table users__role
(
  id          int identity
    constraint users__role_pk
      primary key nonclustered,
  title       varchar(255),
  description varchar(255)
)
go

create table users__user
(
  id         int identity
    constraint PK_user
      primary key,
  name       varchar(255) not null,
  surname    varchar(255) not null,
  password   varchar(255) not null,
  email      varchar(255) not null,
  role_id    int          not null
    constraint FK_users__user_users__role
      references users__role,
  phone      varchar(255) not null,
  address_id int
    constraint FK_users__user_address__address
      references address__address
)
go

create table controls__control
(
  id                 int identity
    constraint PK_controls__control
      primary key,
  title              varchar(255) not null,
  description        text         not null,
  date_performed     datetime,
  date_planned       datetime,
  user_to_perform_id int
    constraint FK_controls__control_users__user1
      references users__user,
  equipment_id       int
    constraint FK_controls__control_equipments__equipment
      references equipments__equipment,
  user_performed_id  int
    constraint FK_controls__control_users__user
      references users__user,
  user_planned_id    int
    constraint FK_controls__control_users__role
      references users__role,
  priority           int
)
go

create table tickets__ticket
(
  id           int identity
    constraint PK_tickets__problem_ticket
      primary key,
  title        varchar(255) not null,
  description  text         not null,
  equipment_id int          not null,
  author_id    int
    constraint FK_tickets__problem_ticket_users__user
      references users__user,
  solver_id    int
    constraint FK_tickets__problem_ticket_users__user1
      references users__user,
  assigned_id  int
    constraint FK_tickets__problem_ticket_tickets__problem_ticket
      references users__role
)
go


CREATE FUNCTION dbo.fn_diagramobjects()
  RETURNS int
  WITH EXECUTE AS N'dbo'
AS
BEGIN
  declare @id_upgraddiagrams int
  declare @id_sysdiagrams int
  declare @id_helpdiagrams int
  declare @id_helpdiagramdefinition int
  declare @id_creatediagram int
  declare @id_renamediagram int
  declare @id_alterdiagram int
  declare @id_dropdiagram int
  declare @InstalledObjects int

  select @InstalledObjects = 0

  select @id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
         @id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
         @id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
         @id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
         @id_creatediagram = object_id(N'dbo.sp_creatediagram'),
         @id_renamediagram = object_id(N'dbo.sp_renamediagram'),
         @id_alterdiagram = object_id(N'dbo.sp_alterdiagram'),
         @id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

  if @id_upgraddiagrams is not null
    select @InstalledObjects = @InstalledObjects + 1
  if @id_sysdiagrams is not null
    select @InstalledObjects = @InstalledObjects + 2
  if @id_helpdiagrams is not null
    select @InstalledObjects = @InstalledObjects + 4
  if @id_helpdiagramdefinition is not null
    select @InstalledObjects = @InstalledObjects + 8
  if @id_creatediagram is not null
    select @InstalledObjects = @InstalledObjects + 16
  if @id_renamediagram is not null
    select @InstalledObjects = @InstalledObjects + 32
  if @id_alterdiagram is not null
    select @InstalledObjects = @InstalledObjects + 64
  if @id_dropdiagram is not null
    select @InstalledObjects = @InstalledObjects + 128

  return @InstalledObjects
END
go


CREATE PROCEDURE dbo.sp_alterdiagram(@diagramname sysname,
                                     @owner_id int = null,
                                     @version int,
                                     @definition varbinary(max))
  WITH EXECUTE AS 'dbo'
AS
BEGIN
  set nocount on

  declare @theId int
  declare @retval int
  declare @IsDbo int

  declare @UIDFound int
  declare @DiagId int
  declare @ShouldChangeUID int

  if (@diagramname is null)
    begin
      RAISERROR ('Invalid ARG', 16, 1)
      return -1
    end

  execute as caller;
  select @theId = DATABASE_PRINCIPAL_ID();
  select @IsDbo = IS_MEMBER(N'db_owner');
  if (@owner_id is null)
    select @owner_id = @theId;
  revert;

  select @ShouldChangeUID = 0
  select @DiagId = diagram_id, @UIDFound = principal_id
  from dbo.sysdiagrams
  where principal_id = @owner_id
    and name = @diagramname

  if (@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
    begin
      RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
      return -3
    end

  if (@IsDbo <> 0)
    begin
      if (@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
        begin
          select @ShouldChangeUID = 1 ;
        end
    end

  -- update dds data			
  update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId;

  -- change owner
  if (@ShouldChangeUID = 1)
    update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId;

  -- update dds version
  if (@version is not null)
    update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

  return 0
END
go


CREATE PROCEDURE dbo.sp_creatediagram(@diagramname sysname,
                                      @owner_id int = null,
                                      @version int,
                                      @definition varbinary(max))
  WITH EXECUTE AS 'dbo'
AS
BEGIN
  set nocount on

  declare @theId int
  declare @retval int
  declare @IsDbo int
  declare @userName sysname
  if (@version is null or @diagramname is null)
    begin
      RAISERROR (N'E_INVALIDARG', 16, 1);
      return -1
    end

  execute as caller;
  select @theId = DATABASE_PRINCIPAL_ID();
  select @IsDbo = IS_MEMBER(N'db_owner');
  revert;

  if @owner_id is null
    begin
      select @owner_id = @theId;
    end
  else
    begin
      if @theId <> @owner_id
        begin
          if @IsDbo = 0
            begin
              RAISERROR (N'E_INVALIDARG', 16, 1);
              return -1
            end
          select @theId = @owner_id
        end
    end
  -- next 2 line only for test, will be removed after define name unique
  if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
    begin
      RAISERROR ('The name is already used.', 16, 1);
      return -2
    end

  insert into dbo.sysdiagrams(name, principal_id, version, definition)
  VALUES (@diagramname, @theId, @version, @definition);

  select @retval = @@IDENTITY
  return @retval
END
go


CREATE PROCEDURE dbo.sp_dropdiagram(@diagramname sysname,
                                    @owner_id int = null)
  WITH EXECUTE AS 'dbo'
AS
BEGIN
  set nocount on
  declare @theId int
  declare @IsDbo int

  declare @UIDFound int
  declare @DiagId int

  if (@diagramname is null)
    begin
      RAISERROR ('Invalid value', 16, 1);
      return -1
    end

  EXECUTE AS CALLER;
  select @theId = DATABASE_PRINCIPAL_ID();
  select @IsDbo = IS_MEMBER(N'db_owner');
  if (@owner_id is null)
    select @owner_id = @theId;
  REVERT;

  select @DiagId = diagram_id, @UIDFound = principal_id
  from dbo.sysdiagrams
  where principal_id = @owner_id
    and name = @diagramname
  if (@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
    begin
      RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
      return -3
    end

  delete from dbo.sysdiagrams where diagram_id = @DiagId;

  return 0;
END
go


CREATE PROCEDURE dbo.sp_helpdiagramdefinition(@diagramname sysname,
                                              @owner_id int = null)
  WITH EXECUTE AS N'dbo'
AS
BEGIN
  set nocount on

  declare @theId int
  declare @IsDbo int
  declare @DiagId int
  declare @UIDFound int

  if (@diagramname is null)
    begin
      RAISERROR (N'E_INVALIDARG', 16, 1);
      return -1
    end

  execute as caller;
  select @theId = DATABASE_PRINCIPAL_ID();
  select @IsDbo = IS_MEMBER(N'db_owner');
  if (@owner_id is null)
    select @owner_id = @theId;
  revert;

  select @DiagId = diagram_id, @UIDFound = principal_id
  from dbo.sysdiagrams
  where principal_id = @owner_id
    and name = @diagramname;
  if (@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
    begin
      RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
      return -3
    end

  select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId;
  return 0
END
go


CREATE PROCEDURE dbo.sp_helpdiagrams(@diagramname sysname = NULL,
                                     @owner_id int = NULL)
  WITH EXECUTE AS N'dbo'
AS
BEGIN
  DECLARE @user sysname
  DECLARE @dboLogin bit
  EXECUTE AS CALLER;
  SET @user = USER_NAME();
  SET @dboLogin = CONVERT(bit, IS_MEMBER('db_owner'));
  REVERT;
  SELECT [Database] = DB_NAME(),
         [Name]     = name,
         [ID]       = diagram_id,
         [Owner]    = USER_NAME(principal_id),
         [OwnerID]  = principal_id
  FROM sysdiagrams
  WHERE (@dboLogin = 1 OR USER_NAME(principal_id) = @user)
    AND (@diagramname IS NULL OR name = @diagramname)
    AND (@owner_id IS NULL OR principal_id = @owner_id)
  ORDER BY 4, 5, 1
END
go


CREATE PROCEDURE dbo.sp_renamediagram(@diagramname sysname,
                                      @owner_id int = null,
                                      @new_diagramname sysname)
  WITH EXECUTE AS 'dbo'
AS
BEGIN
  set nocount on
  declare @theId int
  declare @IsDbo int

  declare @UIDFound int
  declare @DiagId int
  declare @DiagIdTarg int
  declare @u_name sysname
  if ((@diagramname is null) or (@new_diagramname is null))
    begin
      RAISERROR ('Invalid value', 16, 1);
      return -1
    end

  EXECUTE AS CALLER;
  select @theId = DATABASE_PRINCIPAL_ID();
  select @IsDbo = IS_MEMBER(N'db_owner');
  if (@owner_id is null)
    select @owner_id = @theId;
  REVERT;

  select @u_name = USER_NAME(@owner_id)

  select @DiagId = diagram_id, @UIDFound = principal_id
  from dbo.sysdiagrams
  where principal_id = @owner_id
    and name = @diagramname
  if (@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
    begin
      RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
      return -3
    end

  -- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
  --	return 0;

  if (@u_name is null)
    select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
  else
    select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname

  if ((@DiagIdTarg is not null) and @DiagId <> @DiagIdTarg)
    begin
      RAISERROR ('The name is already used.', 16, 1);
      return -2
    end

  if (@u_name is null)
    update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
  else
    update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
  return 0
END
go


CREATE PROCEDURE dbo.sp_upgraddiagrams
AS
BEGIN
  IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
    return 0;

  CREATE TABLE dbo.sysdiagrams
  (
    name         sysname NOT NULL,
    principal_id int     NOT NULL, -- we may change it to varbinary(85)
    diagram_id   int PRIMARY KEY IDENTITY,
    version      int,

    definition   varbinary(max)
      CONSTRAINT UK_principal_name UNIQUE
        (
         principal_id,
         name
          )
  );


  /* Add this if we need to have some form of extended properties for diagrams */
  /*
  IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
  BEGIN
    CREATE TABLE dbo.sysdiagram_properties
    (
      diagram_id int,
      name sysname,
      value varbinary(max) NOT NULL
    )
  END
  */

  IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
    begin
      insert into dbo.sysdiagrams
      ([name],
       [principal_id],
       [version],
       [definition])
      select convert(sysname, dgnm.[uvalue]),
             DATABASE_PRINCIPAL_ID(N'dbo'), -- will change to the sid of sa
             0,                             -- zero for old format, dgdef.[version],
             dgdef.[lvalue]
      from dbo.[dtproperties] dgnm
             inner join dbo.[dtproperties] dggd
                        on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]
             inner join dbo.[dtproperties] dgdef
                        on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]

      where dgnm.[property] = 'DtgSchemaNAME'
        and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_'
      return 2;
    end
  return 1;
END
go

