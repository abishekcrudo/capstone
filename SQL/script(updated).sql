/* ============================================================
   Create SkilloraDB (portable for any local SQL Server)
   ============================================================ */

USE [master];
GO

-- Drop if exists (safe reset)
IF DB_ID(N'SkilloraDB') IS NOT NULL
BEGIN
    ALTER DATABASE [SkilloraDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [SkilloraDB];
END
GO

-- Create database using SQL Server default data/log folders
CREATE DATABASE [SkilloraDB];
GO

-- Recommended for development
ALTER DATABASE [SkilloraDB] SET AUTO_CLOSE OFF;
GO

-- Switch context to SkilloraDB for the rest of the script
USE [SkilloraDB];
GO
/****** Object:  Table [dbo].[activity_logs]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activity_logs](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[action] [varchar](100) NOT NULL,
	[entity_type] [varchar](50) NULL,
	[entity_id] [int] NULL,
	[details] [varchar](500) NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[api_call_logs]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[api_call_logs](
	[api_log_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[api_name] [varchar](80) NOT NULL,
	[request_domain] [varchar](150) NOT NULL,
	[request_time] [datetime] NOT NULL,
	[response_status] [varchar](30) NOT NULL,
	[response_code] [varchar](30) NULL,
	[response_message] [varchar](255) NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[api_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[application_match_scores]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[application_match_scores](
	[match_id] [int] IDENTITY(1,1) NOT NULL,
	[application_id] [int] NOT NULL,
	[score] [decimal](5, 2) NOT NULL,
	[matched_keywords] [varchar](500) NULL,
	[computed_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[match_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[application_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[applications]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[applications](
	[application_id] [int] IDENTITY(1,1) NOT NULL,
	[task_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[status] [varchar](20) NOT NULL,
	[applied_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[application_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_task_student] UNIQUE NONCLUSTERED 
(
	[task_id] ASC,
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[badges]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[badges](
	[badge_id] [int] IDENTITY(1,1) NOT NULL,
	[badge_name] [varchar](80) NOT NULL,
	[criteria] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[badge_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[badge_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[business_profiles]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[business_profiles](
	[business_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[business_name] [varchar](150) NOT NULL,
	[industry] [varchar](80) NULL,
	[website_url] [varchar](255) NULL,
	[description] [varchar](500) NULL,
	[contact_name] [varchar](100) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[business_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[email_send_attempts]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[email_send_attempts](
	[email_attempt_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[token_id] [int] NULL,
	[email_type] [varchar](30) NOT NULL,
	[recipient_email] [varchar](255) NOT NULL,
	[status] [varchar](20) NOT NULL,
	[error_message] [varchar](255) NULL,
	[attempted_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[email_attempt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[email_verification_tokens]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[email_verification_tokens](
	[token_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[verification_type] [varchar](20) NOT NULL,
	[token] [varchar](255) NULL,
	[otp_code_hash] [varchar](255) NULL,
	[expires_at] [datetime] NOT NULL,
	[used_at] [datetime] NULL,
	[resend_count] [tinyint] NOT NULL,
	[last_sent_at] [datetime] NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[token_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[password_reset_tokens]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[password_reset_tokens](
	[reset_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[token] [varchar](255) NOT NULL,
	[expires_at] [datetime] NOT NULL,
	[used_at] [datetime] NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[reset_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ratings]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ratings](
	[rating_id] [int] IDENTITY(1,1) NOT NULL,
	[application_id] [int] NOT NULL,
	[business_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[rating_value] [tinyint] NOT NULL,
	[comment] [varchar](500) NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[rating_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[application_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[recommendations]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[recommendations](
	[recommendation_id] [int] IDENTITY(1,1) NOT NULL,
	[rating_id] [int] NOT NULL,
	[text] [varchar](max) NOT NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[recommendation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[rating_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[resumes]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resumes](
	[resume_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[file_name] [varchar](255) NOT NULL,
	[file_path] [varchar](255) NOT NULL,
	[file_type] [varchar](10) NOT NULL,
	[extracted_text] [varchar](max) NULL,
	[is_primary] [bit] NOT NULL,
	[uploaded_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[resume_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 25-02-2026 17:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [varchar](30) NOT NULL,
	[role_description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[role_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[school_domain_verification]    Script Date: 25-02-2026 17:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[school_domain_verification](
	[verification_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[email_domain] [varchar](150) NOT NULL,
	[is_school_domain] [bit] NOT NULL,
	[provider_name] [varchar](80) NULL,
	[provider_response_code] [varchar](30) NULL,
	[checked_at] [datetime] NOT NULL,
	[raw_response_ref] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[verification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[skills]    Script Date: 25-02-2026 17:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[skills](
	[skill_id] [int] IDENTITY(1,1) NOT NULL,
	[skill_name] [varchar](80) NOT NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[skill_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_badges]    Script Date: 25-02-2026 17:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_badges](
	[student_badge_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[badge_id] [int] NOT NULL,
	[awarded_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[student_badge_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_student_badge] UNIQUE NONCLUSTERED 
(
	[student_id] ASC,
	[badge_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_profiles]    Script Date: 25-02-2026 17:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_profiles](
	[student_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[program_name] [varchar](100) NULL,
	[school_name] [varchar](120) NULL,
	[bio] [varchar](500) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_skills]    Script Date: 25-02-2026 17:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_skills](
	[student_skill_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[skill_id] [int] NOT NULL,
	[proficiency] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[student_skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_student_skill] UNIQUE NONCLUSTERED 
(
	[student_id] ASC,
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[task_skills]    Script Date: 25-02-2026 17:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[task_skills](
	[task_skill_id] [int] IDENTITY(1,1) NOT NULL,
	[task_id] [int] NOT NULL,
	[skill_id] [int] NOT NULL,
	[is_required] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[task_skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_task_skill] UNIQUE NONCLUSTERED 
(
	[task_id] ASC,
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tasks]    Script Date: 25-02-2026 17:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tasks](
	[task_id] [int] IDENTITY(1,1) NOT NULL,
	[business_id] [int] NOT NULL,
	[title] [varchar](150) NOT NULL,
	[description] [varchar](max) NOT NULL,
	[estimated_hours] [tinyint] NOT NULL,
	[status] [varchar](20) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[task_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_roles]    Script Date: 25-02-2026 17:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_roles](
	[user_role_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
	[assigned_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 25-02-2026 17:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[password_hash] [varchar](255) NOT NULL,
	[is_active] [bit] NOT NULL,
	[is_email_verified] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[activity_logs] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[api_call_logs] ADD  DEFAULT (getdate()) FOR [request_time]
GO
ALTER TABLE [dbo].[api_call_logs] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[application_match_scores] ADD  DEFAULT (getdate()) FOR [computed_at]
GO
ALTER TABLE [dbo].[applications] ADD  DEFAULT ('APPLIED') FOR [status]
GO
ALTER TABLE [dbo].[applications] ADD  DEFAULT (getdate()) FOR [applied_at]
GO
ALTER TABLE [dbo].[business_profiles] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[email_send_attempts] ADD  DEFAULT (getdate()) FOR [attempted_at]
GO
ALTER TABLE [dbo].[email_verification_tokens] ADD  DEFAULT ((0)) FOR [resend_count]
GO
ALTER TABLE [dbo].[email_verification_tokens] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[password_reset_tokens] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ratings] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[recommendations] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[resumes] ADD  DEFAULT ((1)) FOR [is_primary]
GO
ALTER TABLE [dbo].[resumes] ADD  DEFAULT (getdate()) FOR [uploaded_at]
GO
ALTER TABLE [dbo].[school_domain_verification] ADD  DEFAULT (getdate()) FOR [checked_at]
GO
ALTER TABLE [dbo].[skills] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[student_badges] ADD  DEFAULT (getdate()) FOR [awarded_at]
GO
ALTER TABLE [dbo].[student_profiles] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[task_skills] ADD  DEFAULT ((1)) FOR [is_required]
GO
ALTER TABLE [dbo].[tasks] ADD  DEFAULT ('OPEN') FOR [status]
GO
ALTER TABLE [dbo].[tasks] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[user_roles] ADD  DEFAULT (getdate()) FOR [assigned_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [is_email_verified]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[activity_logs]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[api_call_logs]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[application_match_scores]  WITH CHECK ADD FOREIGN KEY([application_id])
REFERENCES [dbo].[applications] ([application_id])
GO
ALTER TABLE [dbo].[applications]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[student_profiles] ([student_id])
GO
ALTER TABLE [dbo].[applications]  WITH CHECK ADD FOREIGN KEY([task_id])
REFERENCES [dbo].[tasks] ([task_id])
GO
ALTER TABLE [dbo].[business_profiles]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[email_send_attempts]  WITH CHECK ADD FOREIGN KEY([token_id])
REFERENCES [dbo].[email_verification_tokens] ([token_id])
GO
ALTER TABLE [dbo].[email_send_attempts]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[email_verification_tokens]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[password_reset_tokens]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[ratings]  WITH CHECK ADD FOREIGN KEY([application_id])
REFERENCES [dbo].[applications] ([application_id])
GO
ALTER TABLE [dbo].[ratings]  WITH CHECK ADD FOREIGN KEY([business_id])
REFERENCES [dbo].[business_profiles] ([business_id])
GO
ALTER TABLE [dbo].[ratings]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[student_profiles] ([student_id])
GO
ALTER TABLE [dbo].[recommendations]  WITH CHECK ADD FOREIGN KEY([rating_id])
REFERENCES [dbo].[ratings] ([rating_id])
GO
ALTER TABLE [dbo].[resumes]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[student_profiles] ([student_id])
GO
ALTER TABLE [dbo].[school_domain_verification]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[student_badges]  WITH CHECK ADD FOREIGN KEY([badge_id])
REFERENCES [dbo].[badges] ([badge_id])
GO
ALTER TABLE [dbo].[student_badges]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[student_profiles] ([student_id])
GO
ALTER TABLE [dbo].[student_profiles]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[student_skills]  WITH CHECK ADD FOREIGN KEY([skill_id])
REFERENCES [dbo].[skills] ([skill_id])
GO
ALTER TABLE [dbo].[student_skills]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[student_profiles] ([student_id])
GO
ALTER TABLE [dbo].[task_skills]  WITH CHECK ADD FOREIGN KEY([skill_id])
REFERENCES [dbo].[skills] ([skill_id])
GO
ALTER TABLE [dbo].[task_skills]  WITH CHECK ADD FOREIGN KEY([task_id])
REFERENCES [dbo].[tasks] ([task_id])
GO
ALTER TABLE [dbo].[tasks]  WITH CHECK ADD FOREIGN KEY([business_id])
REFERENCES [dbo].[business_profiles] ([business_id])
GO
ALTER TABLE [dbo].[user_roles]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([role_id])
GO
ALTER TABLE [dbo].[user_roles]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[ratings]  WITH CHECK ADD CHECK  (([rating_value]>=(1) AND [rating_value]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [SkilloraDB] SET  READ_WRITE 
GO
