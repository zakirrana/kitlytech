USE [CTM]
GO
/****** Object:  StoredProcedure [dbo].[sp_site_GetReferalsApointments]    Script Date: 28-07-2020 05:20:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
CREATE proc [dbo].[sp_site_GetReferalsApointments]
 @ReferalId as int=1

as
begin

select a.*,b.ApointMentType,c.Id as EventId from ReferalApointments a inner join 
	[dbo].[ReferalApointmentType] b on a.AppointmentTypeId=b.Id
	left join dbo.ReferalEventDetail c on c.ApointMentId=a.Id
	where a.ReferalId=@ReferalId and a.isDeleted=0
end

GO
/****** Object:  StoredProcedure [dbo].[sp_site_GetReferalsByStudyId]    Script Date: 28-07-2020 05:20:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
CREATE proc [dbo].[sp_site_GetReferalsByStudyId]
 @SiteId as int=1,
 @StudyId as int=2,
 @Search as nvarchar(Max)='',
 @FromRecord bigint=1,
 @ToRecord bigint=100
as
begin


	if(isnull(@Search,'')='')
	begin
		select k.* from (
		select ROW_NUMBER() over (order by a.Id) as Rowno,a.*,b.ReferalStatus,c.ReferalCode,sed.IVRNo  
		from StudySiteReferalMapping a
		left join [dbo].[PatientReferalMapping] c on c.ReferalId=a.RefrelId 
		left join ReferalStatus b on a.ReferalStatusId=b.Id 
		left join ReferalEventDetail sed on sed.ReferalId=a.RefrelId and isnull(sed.IVRNo,'')<>''
		
		where a.SiteId=@SiteId and a.StudyId=@StudyId
		) k
		where  k.Rowno between @FromRecord and @ToRecord
		  
	end
	else
	begin
	select k.* from (
	select ROW_NUMBER() over (order by a.Id) as Rowno,a.*,b.ReferalStatus,c.ReferalCode,sed.IVRNo  
		from StudySiteReferalMapping a
		left join [dbo].[PatientReferalMapping] c on c.ReferalId=a.RefrelId 
		left join ReferalStatus b on a.ReferalStatusId=b.Id 
		left join ReferalEventDetail sed on sed.ReferalId=a.RefrelId and isnull(sed.IVRNo,'')<>''
		
		where a.SiteId=@SiteId and a.StudyId=@StudyId
		) k
		where  k.Rowno between @FromRecord and @ToRecord
	end
end

GO
/****** Object:  StoredProcedure [dbo].[sp_site_GetReferalsDetail]    Script Date: 28-07-2020 05:20:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
CREATE proc [dbo].[sp_site_GetReferalsDetail]
 @ReferalId as int=1,
 @StudyId as int=1
as
begin

select a.*,b.ReferalCode,refs.ReferalStatus,b.StudyId,c.SiteId from PatientDetail a inner join PatientReferalMapping b
on a.Id=b.PatientId and b.ReferalId=@ReferalId
left join StudySiteReferalMapping c on c.StudyId=@StudyId and c.RefrelId=@ReferalId
left join ReferalStatus refs on refs.Id=c.ReferalStatusId
	
end

GO
/****** Object:  StoredProcedure [dbo].[sp_site_GetReferalsEvents]    Script Date: 28-07-2020 05:20:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
CREATE proc [dbo].[sp_site_GetReferalsEvents]
 @ReferalId as int=1

as
begin
select a.*,b.EventType,c.EventStatus,d.ReferalStatus,e.ProtocolText,f.Reason from [dbo].[ReferalEventDetail] a 
left join
ReferalEventType b on b.Id=a.EventtypeId
left join [dbo].[ReferalEventStatus] c on c.Id=a.EventStatusId
left join ReferalStatus d on d.Id=a.[ReferalStatusId]
left join StudyProtocol e on e.id=a.[ApplicableProtocolid]
left join [dbo].[SiteReferalStatusReason] f on f.StatusId=a.referalStatusid and f.Id=@ReferalId
where a.referalId=@ReferalId and a.isDeleted=0

end

GO
/****** Object:  StoredProcedure [dbo].[sp_site_GetStudiesBySiteId]    Script Date: 28-07-2020 05:20:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
CREATE proc [dbo].[sp_site_GetStudiesBySiteId]
 @SiteID as int,
 @Search as nvarchar(Max),
 @FromRecord bigint,
 @ToRecord bigint
as
begin


	if(isnull(@Search,'')='')
	begin
		select k.* from (
		select ROW_NUMBER() over (order by a.Id) as Rowno,a.*,b.Status from Studies a inner join StudyStatus b
		on a.StatusId=b.Id 
		where a.Id in (select distinct StudyId from StudySiteReferalMapping where SiteId=@SiteID)) k
		where  k.Rowno between @FromRecord and @ToRecord
		  
	end
	else
	begin
	select k.* from (
	select ROW_NUMBER() over (order by a.Id) as Rowno,a.*,b.Status from Studies a inner join StudyStatus b
		on a.StatusId=b.Id 
		where a.Id in (select distinct StudyId from StudySiteReferalMapping where SiteId=@SiteID)
		and (a.StudyTitle Like '%' + @Search + '%' or b.Status Like '%' + @Search + '%')
		
		) k
		where  k.Rowno between @FromRecord and @ToRecord
	end
end

GO
/****** Object:  Table [dbo].[PatientDetail]    Script Date: 28-07-2020 05:20:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[EmailAddress] [nvarchar](200) NULL,
	[HomePhoneNumber] [nvarchar](100) NULL,
	[CellPhoneNumber] [nvarchar](100) NULL,
	[Address] [nvarchar](200) NULL,
	[City] [nvarchar](50) NULL,
	[Zip] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[CareGiversName] [nvarchar](100) NULL,
	[CareGiverrsPhone] [nvarchar](100) NULL,
 CONSTRAINT [PK_PatientDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientReferalMapping]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientReferalMapping](
	[ReferalId] [int] IDENTITY(1,1) NOT NULL,
	[ReferalCode]  AS ('REF-'+CONVERT([nvarchar](500),[ReferalId])) PERSISTED,
	[StudyId] [int] NULL,
	[PatientId] [int] NULL,
 CONSTRAINT [PK_PatientReferalMapping] PRIMARY KEY CLUSTERED 
(
	[ReferalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ReferalApointments]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferalApointments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentTypeId] [int] NULL,
	[ApointmentDate] [datetime] NULL,
	[Note] [nvarchar](max) NULL,
	[ReferalId] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_ReferalApointments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferalApointmentType]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferalApointmentType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApointMentType] [nvarchar](250) NULL,
 CONSTRAINT [PK_ReferalApointmentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferalEventDetail]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferalEventDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventTypeId] [int] NOT NULL,
	[EventDate] [datetime] NULL,
	[Comment] [nvarchar](max) NULL,
	[ReferalStatusId] [int] NULL,
	[EventStatusId] [int] NULL,
	[IVRNo] [nvarchar](100) NULL,
	[ReferalId] [int] NULL,
	[ApplicableProtocolid] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ReferalStatusResonId] [int] NULL,
	[ApointMentId] [int] NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_SiteEventDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferalEventStatus]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferalEventStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventStatus] [nvarchar](250) NULL,
 CONSTRAINT [PK_EventStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferalEventType]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferalEventType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventType] [nvarchar](500) NULL,
 CONSTRAINT [PK_SiteEventType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferalPreQualificationDetail]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferalPreQualificationDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NULL,
	[AnswerIds] [nvarchar](500) NULL,
	[ReferalId] [int] NULL,
	[PreScreeningDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_ReferalPreQualificationDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferalStatus]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferalStatus](
	[Id] [int] NOT NULL,
	[ReferalStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_ReferalStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SendSmsOrEmail]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SendSmsOrEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MessageReciver] [nvarchar](500) NULL,
	[From] [nvarchar](200) NULL,
	[To] [nvarchar](max) NULL,
	[Subject] [nvarchar](500) NULL,
	[MessgeType] [int] NULL,
	[MessageDate] [datetime] NULL,
	[MessageContent] [nvarchar](max) NULL,
	[AttachementPath] [nvarchar](255) NULL,
	[isMessagesent] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_SendSmsOrEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SiteMaster]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SiteName] [nvarchar](200) NULL,
	[SiteAddress] [nvarchar](500) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[MobileNumber] [nvarchar](50) NULL,
	[EmailAddress] [nvarchar](100) NULL,
 CONSTRAINT [PK_SiteMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SiteReferalStatusReason]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteReferalStatusReason](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Reason] [nvarchar](500) NULL,
	[StatusId] [int] NULL,
 CONSTRAINT [PK_SiteReferalStatusResion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Studies]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Studies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudyCode]  AS ('STUD-'+CONVERT([nvarchar](500),[Id])) PERSISTED,
	[StudyTitle] [nvarchar](500) NULL,
	[StatusId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ModyfiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_KT_Studies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StudyProtocol]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudyProtocol](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProtocolText] [nvarchar](300) NULL,
	[StudyId] [int] NULL,
 CONSTRAINT [PK_StudyProtocol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudySiteReferalMapping]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudySiteReferalMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudyId] [int] NULL,
	[SiteId] [int] NULL,
	[RefrelId] [int] NULL,
	[ReferalStatusId] [int] NULL,
 CONSTRAINT [PK_StudySiteMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudyStatus]    Script Date: 28-07-2020 05:20:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudyStatus](
	[Id] [int] NOT NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK_StudyStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[PatientDetail] ON 

GO
INSERT [dbo].[PatientDetail] ([Id], [FirstName], [MiddleName], [LastName], [EmailAddress], [HomePhoneNumber], [CellPhoneNumber], [Address], [City], [Zip], [State], [Country], [CareGiversName], [CareGiverrsPhone]) VALUES (1, N'Zakir', N'Rana', N'M', N'zakir@test.com', N'1234567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[PatientDetail] ([Id], [FirstName], [MiddleName], [LastName], [EmailAddress], [HomePhoneNumber], [CellPhoneNumber], [Address], [City], [Zip], [State], [Country], [CareGiversName], [CareGiverrsPhone]) VALUES (2, N'Ronak', N'Patel', NULL, N'ronak@test.com', N'14567', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[PatientDetail] ([Id], [FirstName], [MiddleName], [LastName], [EmailAddress], [HomePhoneNumber], [CellPhoneNumber], [Address], [City], [Zip], [State], [Country], [CareGiversName], [CareGiverrsPhone]) VALUES (3, N'Viral', NULL, N'Patel', N'viral@test.com', N'12345678', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[PatientDetail] OFF
GO
SET ANSI_PADDING ON
GO
SET IDENTITY_INSERT [dbo].[PatientReferalMapping] ON 

GO
INSERT [dbo].[PatientReferalMapping] ([ReferalId], [StudyId], [PatientId]) VALUES (1, 1, 1)
GO
INSERT [dbo].[PatientReferalMapping] ([ReferalId], [StudyId], [PatientId]) VALUES (2, 2, 2)
GO
INSERT [dbo].[PatientReferalMapping] ([ReferalId], [StudyId], [PatientId]) VALUES (3, 3, 3)
GO
INSERT [dbo].[PatientReferalMapping] ([ReferalId], [StudyId], [PatientId]) VALUES (4, 1, 2)
GO
INSERT [dbo].[PatientReferalMapping] ([ReferalId], [StudyId], [PatientId]) VALUES (5, 2, 3)
GO
INSERT [dbo].[PatientReferalMapping] ([ReferalId], [StudyId], [PatientId]) VALUES (6, 3, 1)
GO
SET IDENTITY_INSERT [dbo].[PatientReferalMapping] OFF
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ReferalApointments] ON 

GO
INSERT [dbo].[ReferalApointments] ([Id], [AppointmentTypeId], [ApointmentDate], [Note], [ReferalId], [CreatedOn], [isDeleted]) VALUES (2, 2, CAST(N'2020-11-01 00:00:00.000' AS DateTime), N'zakir', 2, CAST(N'2020-07-04 00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[ReferalApointments] ([Id], [AppointmentTypeId], [ApointmentDate], [Note], [ReferalId], [CreatedOn], [isDeleted]) VALUES (1002, 2, CAST(N'2020-11-01 00:00:00.000' AS DateTime), N'zakir', 2, CAST(N'2020-07-17 00:00:00.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[ReferalApointments] OFF
GO
SET IDENTITY_INSERT [dbo].[ReferalApointmentType] ON 

GO
INSERT [dbo].[ReferalApointmentType] ([Id], [ApointMentType]) VALUES (1, N'First Site Visit')
GO
INSERT [dbo].[ReferalApointmentType] ([Id], [ApointMentType]) VALUES (2, N'Other Visit')
GO
SET IDENTITY_INSERT [dbo].[ReferalApointmentType] OFF
GO
SET IDENTITY_INSERT [dbo].[ReferalEventDetail] ON 

GO
INSERT [dbo].[ReferalEventDetail] ([Id], [EventTypeId], [EventDate], [Comment], [ReferalStatusId], [EventStatusId], [IVRNo], [ReferalId], [ApplicableProtocolid], [CreatedOn], [ReferalStatusResonId], [ApointMentId], [isDeleted]) VALUES (2, 2, CAST(N'2020-11-05 00:00:00.000' AS DateTime), N'secound event', 2, 2, N'', 1, NULL, CAST(N'2020-07-04 00:00:00.000' AS DateTime), 5, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[ReferalEventDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[ReferalEventStatus] ON 

GO
INSERT [dbo].[ReferalEventStatus] ([Id], [EventStatus]) VALUES (1, N'Site Visit Scheduled')
GO
INSERT [dbo].[ReferalEventStatus] ([Id], [EventStatus]) VALUES (2, N'Failed Attempt')
GO
SET IDENTITY_INSERT [dbo].[ReferalEventStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[ReferalEventType] ON 

GO
INSERT [dbo].[ReferalEventType] ([Id], [EventType]) VALUES (1, N'Pre-Screening')
GO
INSERT [dbo].[ReferalEventType] ([Id], [EventType]) VALUES (2, N'Phone-Screening')
GO
INSERT [dbo].[ReferalEventType] ([Id], [EventType]) VALUES (3, N'Office-Screening
')
GO
INSERT [dbo].[ReferalEventType] ([Id], [EventType]) VALUES (4, N'Study Specific Testing Screening')
GO
INSERT [dbo].[ReferalEventType] ([Id], [EventType]) VALUES (6, N'Randomizing')
GO
INSERT [dbo].[ReferalEventType] ([Id], [EventType]) VALUES (7, N'Other')
GO
INSERT [dbo].[ReferalEventType] ([Id], [EventType]) VALUES (8, N'First Site Visit')
GO
SET IDENTITY_INSERT [dbo].[ReferalEventType] OFF
GO
INSERT [dbo].[ReferalStatus] ([Id], [ReferalStatus]) VALUES (1, N'Disposed')
GO
INSERT [dbo].[ReferalStatus] ([Id], [ReferalStatus]) VALUES (2, N'Pre-Qualified (PQ)')
GO
INSERT [dbo].[ReferalStatus] ([Id], [ReferalStatus]) VALUES (3, N'Pre-Qualified (PQ)-Disqualified (DQ)')
GO
INSERT [dbo].[ReferalStatus] ([Id], [ReferalStatus]) VALUES (4, N'Disqualified (DQ)')
GO
INSERT [dbo].[ReferalStatus] ([Id], [ReferalStatus]) VALUES (5, N'Consented')
GO
INSERT [dbo].[ReferalStatus] ([Id], [ReferalStatus]) VALUES (6, N'Disqualifed')
GO
INSERT [dbo].[ReferalStatus] ([Id], [ReferalStatus]) VALUES (7, N'Randomized')
GO
SET IDENTITY_INSERT [dbo].[SiteMaster] ON 

GO
INSERT [dbo].[SiteMaster] ([Id], [SiteName], [SiteAddress], [PhoneNumber], [MobileNumber], [EmailAddress]) VALUES (1, N'Lab1-Gotri', N'hdsjak,jsdasda,sadsadhj', N'2132321', N'2312312', NULL)
GO
INSERT [dbo].[SiteMaster] ([Id], [SiteName], [SiteAddress], [PhoneNumber], [MobileNumber], [EmailAddress]) VALUES (2, N'Lab2-Subhanpura', N'ksdjdsa,dsaddasd', N'34232312', N'3432432', NULL)
GO
INSERT [dbo].[SiteMaster] ([Id], [SiteName], [SiteAddress], [PhoneNumber], [MobileNumber], [EmailAddress]) VALUES (3, N'Lab3-Gorva', N'dksdjksa,dsdjasdja', N'2323211', N'123123123', NULL)
GO
SET IDENTITY_INSERT [dbo].[SiteMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[SiteReferalStatusReason] ON 

GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (1, N'Hang up', 1)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (2, N'Disconnected Call', 1)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (3, N'Wrong Number', 1)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (4, N'Language Barrier', 1)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (5, N'Other', 1)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (6, N'Waiting for site', 3)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (7, N'Calling for Other', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (8, N'No Interest', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (9, N'N/A', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (10, N'No Site', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (11, N'Unable to contact', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (12, N'Phone Screen Fail', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (13, N'No further interested (No Appointment)', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (14, N'No further interested (Post Appointment)', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (15, N'Office Screen Fail', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (16, N'Study Specific Testing Screen Fail', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (17, N'Under age', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (18, N'Age', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (19, N'BMI', 4)
GO
INSERT [dbo].[SiteReferalStatusReason] ([Id], [Reason], [StatusId]) VALUES (20, N'No further interested', 6)
GO
SET IDENTITY_INSERT [dbo].[SiteReferalStatusReason] OFF
GO
SET ANSI_PADDING ON
GO
SET IDENTITY_INSERT [dbo].[Studies] ON 

GO
INSERT [dbo].[Studies] ([Id], [StudyTitle], [StatusId], [CreatedBy], [CreatedOn], [ModyfiedBy], [ModifiedOn]) VALUES (1, N'Covid-19', 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Studies] ([Id], [StudyTitle], [StatusId], [CreatedBy], [CreatedOn], [ModyfiedBy], [ModifiedOn]) VALUES (2, N'Dengu', 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Studies] ([Id], [StudyTitle], [StatusId], [CreatedBy], [CreatedOn], [ModyfiedBy], [ModifiedOn]) VALUES (3, N'Cencer', 1, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Studies] OFF
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[StudySiteReferalMapping] ON 

GO
INSERT [dbo].[StudySiteReferalMapping] ([Id], [StudyId], [SiteId], [RefrelId], [ReferalStatusId]) VALUES (1, 1, 1, 1, 2)
GO
INSERT [dbo].[StudySiteReferalMapping] ([Id], [StudyId], [SiteId], [RefrelId], [ReferalStatusId]) VALUES (2, 1, 1, 2, 1)
GO
INSERT [dbo].[StudySiteReferalMapping] ([Id], [StudyId], [SiteId], [RefrelId], [ReferalStatusId]) VALUES (3, 1, 1, 3, 1)
GO
INSERT [dbo].[StudySiteReferalMapping] ([Id], [StudyId], [SiteId], [RefrelId], [ReferalStatusId]) VALUES (4, 2, 1, 1, 1)
GO
INSERT [dbo].[StudySiteReferalMapping] ([Id], [StudyId], [SiteId], [RefrelId], [ReferalStatusId]) VALUES (5, 3, 1, 1, 1)
GO
INSERT [dbo].[StudySiteReferalMapping] ([Id], [StudyId], [SiteId], [RefrelId], [ReferalStatusId]) VALUES (6, 1, 2, 3, 1)
GO
INSERT [dbo].[StudySiteReferalMapping] ([Id], [StudyId], [SiteId], [RefrelId], [ReferalStatusId]) VALUES (7, 2, 2, 2, 1)
GO
SET IDENTITY_INSERT [dbo].[StudySiteReferalMapping] OFF
GO
INSERT [dbo].[StudyStatus] ([Id], [Status]) VALUES (1, N'Active')
GO
INSERT [dbo].[StudyStatus] ([Id], [Status]) VALUES (2, N'InActive')
GO
INSERT [dbo].[StudyStatus] ([Id], [Status]) VALUES (3, N'Close')
GO
ALTER TABLE [dbo].[PatientReferalMapping]  WITH CHECK ADD  CONSTRAINT [FK_PatientReferalMapping_PatientDetail] FOREIGN KEY([PatientId])
REFERENCES [dbo].[PatientDetail] ([Id])
GO
ALTER TABLE [dbo].[PatientReferalMapping] CHECK CONSTRAINT [FK_PatientReferalMapping_PatientDetail]
GO
ALTER TABLE [dbo].[ReferalApointments]  WITH CHECK ADD  CONSTRAINT [FK_ReferalApointments_PatientReferalMapping] FOREIGN KEY([ReferalId])
REFERENCES [dbo].[PatientReferalMapping] ([ReferalId])
GO
ALTER TABLE [dbo].[ReferalApointments] CHECK CONSTRAINT [FK_ReferalApointments_PatientReferalMapping]
GO
ALTER TABLE [dbo].[ReferalEventDetail]  WITH CHECK ADD  CONSTRAINT [FK_SiteEventDetail_PatientReferalMapping] FOREIGN KEY([ReferalId])
REFERENCES [dbo].[PatientReferalMapping] ([ReferalId])
GO
ALTER TABLE [dbo].[ReferalEventDetail] CHECK CONSTRAINT [FK_SiteEventDetail_PatientReferalMapping]
GO
ALTER TABLE [dbo].[ReferalEventDetail]  WITH CHECK ADD  CONSTRAINT [FK_SiteEventDetail_SiteEventType] FOREIGN KEY([EventTypeId])
REFERENCES [dbo].[ReferalEventType] ([Id])
GO
ALTER TABLE [dbo].[ReferalEventDetail] CHECK CONSTRAINT [FK_SiteEventDetail_SiteEventType]
GO
ALTER TABLE [dbo].[ReferalPreQualificationDetail]  WITH CHECK ADD  CONSTRAINT [FK_ReferalPreQualificationDetail_PatientReferalMapping] FOREIGN KEY([ReferalId])
REFERENCES [dbo].[PatientReferalMapping] ([ReferalId])
GO
ALTER TABLE [dbo].[ReferalPreQualificationDetail] CHECK CONSTRAINT [FK_ReferalPreQualificationDetail_PatientReferalMapping]
GO
ALTER TABLE [dbo].[SiteReferalStatusReason]  WITH CHECK ADD  CONSTRAINT [FK_SiteReferalStatusReason_ReferalStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[ReferalStatus] ([Id])
GO
ALTER TABLE [dbo].[SiteReferalStatusReason] CHECK CONSTRAINT [FK_SiteReferalStatusReason_ReferalStatus]
GO
ALTER TABLE [dbo].[Studies]  WITH NOCHECK ADD  CONSTRAINT [FK_Studies_StudyStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[StudyStatus] ([Id])
GO
ALTER TABLE [dbo].[Studies] CHECK CONSTRAINT [FK_Studies_StudyStatus]
GO
ALTER TABLE [dbo].[StudyProtocol]  WITH CHECK ADD  CONSTRAINT [FK_StudyProtocol_Studies] FOREIGN KEY([StudyId])
REFERENCES [dbo].[Studies] ([Id])
GO
ALTER TABLE [dbo].[StudyProtocol] CHECK CONSTRAINT [FK_StudyProtocol_Studies]
GO
ALTER TABLE [dbo].[StudySiteReferalMapping]  WITH CHECK ADD  CONSTRAINT [FK_StudySiteReferalMapping_SiteMaster] FOREIGN KEY([SiteId])
REFERENCES [dbo].[SiteMaster] ([Id])
GO
ALTER TABLE [dbo].[StudySiteReferalMapping] CHECK CONSTRAINT [FK_StudySiteReferalMapping_SiteMaster]
GO
ALTER TABLE [dbo].[StudySiteReferalMapping]  WITH CHECK ADD  CONSTRAINT [FK_StudySiteReferalMapping_Studies] FOREIGN KEY([StudyId])
REFERENCES [dbo].[Studies] ([Id])
GO
ALTER TABLE [dbo].[StudySiteReferalMapping] CHECK CONSTRAINT [FK_StudySiteReferalMapping_Studies]
GO
