USE [CTM]
GO
/****** Object:  StoredProcedure [dbo].[sp_site_GetStudiesBySiteId]    Script Date: 27-06-2020 19:17:07 ******/
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
/****** Object:  Table [dbo].[PatientDetail]    Script Date: 27-06-2020 19:17:07 ******/
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
 CONSTRAINT [PK_PatientDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientReferalMapping]    Script Date: 27-06-2020 19:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientReferalMapping](
	[ReferalId] [int] NOT NULL,
	[StudyId] [int] NULL,
	[PatientId] [int] NULL,
	[ReferalStatusId] [int] NULL,
 CONSTRAINT [PK_PatientReferalMapping] PRIMARY KEY CLUSTERED 
(
	[ReferalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferalApointments]    Script Date: 27-06-2020 19:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferalApointments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentType] [nvarchar](100) NULL,
	[ApointmentDate] [datetime] NULL,
	[Note] [nvarchar](max) NULL,
	[ReferalId] [int] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_ReferalApointments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferalPreQualificationDetail]    Script Date: 27-06-2020 19:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferalPreQualificationDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Questions] [nvarchar](max) NULL,
	[Response] [nvarchar](500) NULL,
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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferalStatus]    Script Date: 27-06-2020 19:17:07 ******/
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
/****** Object:  Table [dbo].[SiteEventDetail]    Script Date: 27-06-2020 19:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteEventDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SiteEventTypeId] [int] NOT NULL,
	[EventDate] [datetime] NULL,
	[Comment] [nvarchar](max) NULL,
	[PhoneScreeningResult] [nvarchar](100) NULL,
	[ReferalStatusId] [int] NULL,
	[IVRNo] [nvarchar](100) NULL,
	[ReferalId] [int] NULL,
	[ApplicableProtocolid] [int] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_SiteEventDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SiteEventType]    Script Date: 27-06-2020 19:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteEventType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventType] [nvarchar](500) NULL,
 CONSTRAINT [PK_SiteEventType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SiteReferalStatusReason]    Script Date: 27-06-2020 19:17:07 ******/
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
/****** Object:  Table [dbo].[Studies]    Script Date: 27-06-2020 19:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Studies](
	[Id] [int] NOT NULL,
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
/****** Object:  Table [dbo].[StudyProtocol]    Script Date: 27-06-2020 19:17:07 ******/
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
/****** Object:  Table [dbo].[StudySiteReferalMapping]    Script Date: 27-06-2020 19:17:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudySiteReferalMapping](
	[Id] [int] NOT NULL,
	[StudyId] [int] NULL,
	[SiteId] [int] NULL,
	[RefrelId] [int] NULL,
 CONSTRAINT [PK_StudySiteMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudyStatus]    Script Date: 27-06-2020 19:17:07 ******/
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
SET IDENTITY_INSERT [dbo].[SiteEventType] ON 

GO
INSERT [dbo].[SiteEventType] ([Id], [EventType]) VALUES (1, N'Pre-Screening')
GO
INSERT [dbo].[SiteEventType] ([Id], [EventType]) VALUES (2, N'Phone-Screening')
GO
INSERT [dbo].[SiteEventType] ([Id], [EventType]) VALUES (3, N'Office-Screening
')
GO
INSERT [dbo].[SiteEventType] ([Id], [EventType]) VALUES (4, N'Study Specific Testing Screening')
GO
INSERT [dbo].[SiteEventType] ([Id], [EventType]) VALUES (6, N'Randomizing')
GO
INSERT [dbo].[SiteEventType] ([Id], [EventType]) VALUES (7, N'Other')
GO
INSERT [dbo].[SiteEventType] ([Id], [EventType]) VALUES (8, N'First Site Visit')
GO
SET IDENTITY_INSERT [dbo].[SiteEventType] OFF
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
ALTER TABLE [dbo].[PatientReferalMapping]  WITH CHECK ADD  CONSTRAINT [FK_PatientReferalMapping_ReferalStatus] FOREIGN KEY([ReferalStatusId])
REFERENCES [dbo].[ReferalStatus] ([Id])
GO
ALTER TABLE [dbo].[PatientReferalMapping] CHECK CONSTRAINT [FK_PatientReferalMapping_ReferalStatus]
GO
ALTER TABLE [dbo].[ReferalApointments]  WITH CHECK ADD  CONSTRAINT [FK_ReferalApointments_PatientReferalMapping] FOREIGN KEY([ReferalId])
REFERENCES [dbo].[PatientReferalMapping] ([ReferalId])
GO
ALTER TABLE [dbo].[ReferalApointments] CHECK CONSTRAINT [FK_ReferalApointments_PatientReferalMapping]
GO
ALTER TABLE [dbo].[ReferalPreQualificationDetail]  WITH CHECK ADD  CONSTRAINT [FK_ReferalPreQualificationDetail_PatientReferalMapping] FOREIGN KEY([ReferalId])
REFERENCES [dbo].[PatientReferalMapping] ([ReferalId])
GO
ALTER TABLE [dbo].[ReferalPreQualificationDetail] CHECK CONSTRAINT [FK_ReferalPreQualificationDetail_PatientReferalMapping]
GO
ALTER TABLE [dbo].[SiteEventDetail]  WITH CHECK ADD  CONSTRAINT [FK_SiteEventDetail_PatientReferalMapping] FOREIGN KEY([ReferalId])
REFERENCES [dbo].[PatientReferalMapping] ([ReferalId])
GO
ALTER TABLE [dbo].[SiteEventDetail] CHECK CONSTRAINT [FK_SiteEventDetail_PatientReferalMapping]
GO
ALTER TABLE [dbo].[SiteEventDetail]  WITH CHECK ADD  CONSTRAINT [FK_SiteEventDetail_SiteEventType] FOREIGN KEY([SiteEventTypeId])
REFERENCES [dbo].[SiteEventType] ([Id])
GO
ALTER TABLE [dbo].[SiteEventDetail] CHECK CONSTRAINT [FK_SiteEventDetail_SiteEventType]
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
ALTER TABLE [dbo].[StudySiteReferalMapping]  WITH CHECK ADD  CONSTRAINT [FK_StudySiteReferalMapping_Studies] FOREIGN KEY([StudyId])
REFERENCES [dbo].[Studies] ([Id])
GO
ALTER TABLE [dbo].[StudySiteReferalMapping] CHECK CONSTRAINT [FK_StudySiteReferalMapping_Studies]
GO
