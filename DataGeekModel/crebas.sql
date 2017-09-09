/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     9/9/2017 10:49:09 PM                         */
/*==============================================================*/


drop index Index_1;

drop table ARTICALS;

drop index IND_CATENAME;

drop index IND_PARENTID;

drop table ARTICAL_CATEGORIES;

drop index IND_ARTICAL_IMG_ID;

drop table ARTICAL_IMAGES;

drop index IND_ARTICAL_TAG_ID;

drop table ARTICAL_R_TAGS;

drop index IND_TAGNAME;

drop table ARTICAL_TAGS;

drop index IND_COMMENT;

drop index IND_USER_ARTICAL_ID;

drop table COMMENTS;

drop index IND_COMMENTID;

drop table COMMENT_REPLIES;

drop index IND_PK;

drop table IMAGES;

drop index IND_LOGTIME;

drop index IND_USERID;

drop table LOGING_LOGS;

drop index IND_MOBILE;

drop index IND_USERNAME;

drop index IND_EMAIL;

drop table USERS;

drop index IND_USR_ARTICAL_ID;

drop table USERS_ARTICALS;

drop index IND_USER_IMG_ID;

drop table USER_IMAGES;

drop index rolename;

drop index pk;

drop table USER_ROLES;

drop index IND_USR_ROLE;

drop table USER_R_ROLES;

drop index USR_TAG_ID;

drop table USER_R_TAGS;

drop index IND_TAG_NAME;

drop table USER_TAGS;

/*==============================================================*/
/* Table: ARTICALS                                              */
/*==============================================================*/
create table ARTICALS (
   articalid            UUID                 not null,
   content              VBIN10000            null,
   cateid               UUID                 null,
   readcount            INT4                 not null default 0
      constraint CKC_READCOUNT_ARTICALS check (readcount >= 0),
   sharecount           INT4                 not null default 0
      constraint CKC_SHARECOUNT_ARTICALS check (sharecount >= 0),
   createts             TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   updateby             UUID                 null,
   updatets             TIMESTAMP WITH TIME ZONE null,
   constraint PK_ARTICALS primary key (articalid)
);

/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create unique index Index_1 on ARTICALS (
articalid
);

/*==============================================================*/
/* Table: ARTICAL_CATEGORIES                                    */
/*==============================================================*/
create table ARTICAL_CATEGORIES (
   cateid               UUID                 not null,
   parentid             UUID                 null,
   catename             VARCHAR(50)          not null,
   catedesc             VARCHAR(255)         null,
   createby             UUID                 not null,
   createts             TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   updateby             UUID                 null,
   upatets              TIMESTAMP WITH TIME ZONE null,
   constraint PK_ARTICAL_CATEGORIES primary key (cateid)
);

/*==============================================================*/
/* Index: IND_PARENTID                                          */
/*==============================================================*/
create  index IND_PARENTID on ARTICAL_CATEGORIES (
parentid
);

/*==============================================================*/
/* Index: IND_CATENAME                                          */
/*==============================================================*/
create  index IND_CATENAME on ARTICAL_CATEGORIES (
catename
);

/*==============================================================*/
/* Table: ARTICAL_IMAGES                                        */
/*==============================================================*/
create table ARTICAL_IMAGES (
   uid                  UUID                 not null,
   articalid            UUID                 not null,
   imgeid               UUID                 not null,
   createtime           TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   constraint PK_ARTICAL_IMAGES primary key (uid),
   constraint AK_UNIQUE_ARTICAL_IMAGES unique (articalid, imgeid)
);

/*==============================================================*/
/* Index: IND_ARTICAL_IMG_ID                                    */
/*==============================================================*/
create unique index IND_ARTICAL_IMG_ID on ARTICAL_IMAGES (
articalid,
imgeid
);

/*==============================================================*/
/* Table: ARTICAL_R_TAGS                                        */
/*==============================================================*/
create table ARTICAL_R_TAGS (
   uid                  UUID                 not null,
   articalid            UUID                 not null,
   tagid                UUID                 not null,
   createts             TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   constraint PK_ARTICAL_R_TAGS primary key (uid),
   constraint AK_UNIQUE_ARTICAL_R_TAGS unique (articalid, tagid)
);

/*==============================================================*/
/* Index: IND_ARTICAL_TAG_ID                                    */
/*==============================================================*/
create unique index IND_ARTICAL_TAG_ID on ARTICAL_R_TAGS (
articalid,
tagid
);

/*==============================================================*/
/* Table: ARTICAL_TAGS                                          */
/*==============================================================*/
create table ARTICAL_TAGS (
   tagid                UUID                 not null,
   tagname              VARCHAR(50)          not null,
   tagdes               VARCHAR(255)         null,
   createby             UUID                 null,
   createts             TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   constraint PK_ARTICAL_TAGS primary key (tagid)
);

/*==============================================================*/
/* Index: IND_TAGNAME                                           */
/*==============================================================*/
create  index IND_TAGNAME on ARTICAL_TAGS (
tagname
);

/*==============================================================*/
/* Table: COMMENTS                                              */
/*==============================================================*/
create table COMMENTS (
   commentid            UUID                 not null,
   comment              VARCHAR(1024)        not null,
   articalid            UUID                 null,
   userid               UUID                 null,
   stars                SF(4)                null default 0
      constraint CKC_STARS_COMMENTS check (stars is null or (stars between 0 and 5)),
   latitude             DECIMAL(15,6)        null,
   longtitude           DECIMAL(15,6)        null,
   ip                   CIDR                 null,
   addr                 VARCHAR(255)         null,
   createby             UUID                 not null,
   createts             TIMESTAMP WITH TIME ZONE null,
   constraint PK_COMMENTS primary key (commentid)
);

/*==============================================================*/
/* Index: IND_USER_ARTICAL_ID                                   */
/*==============================================================*/
create  index IND_USER_ARTICAL_ID on COMMENTS (
articalid,
userid
);

/*==============================================================*/
/* Index: IND_COMMENT                                           */
/*==============================================================*/
create  index IND_COMMENT on COMMENTS (
comment
);

/*==============================================================*/
/* Table: COMMENT_REPLIES                                       */
/*==============================================================*/
create table COMMENT_REPLIES (
   uid                  SERIAL               not null,
   commentid            UUID                 null,
   replyby              UUID                 null,
   replymsg             VARCHAR(1024)        null,
   replyts              TIMESTAMP WITH TIME ZONE null,
   constraint PK_COMMENT_REPLIES primary key (uid)
);

/*==============================================================*/
/* Index: IND_COMMENTID                                         */
/*==============================================================*/
create  index IND_COMMENTID on COMMENT_REPLIES (
commentid
);

/*==============================================================*/
/* Table: IMAGES                                                */
/*==============================================================*/
create table IMAGES (
   imgeid               UUID                 not null,
   imgdesc              VARCHAR(255)         null,
   latitude             DECIMAL(15,6)        null,
   longtitude           DECIMAL(15,6)        null,
   ip                   CIDR                 null,
   addr                 VARCHAR(255)         null,
   uploadtime           TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   constraint PK_IMAGES primary key (imgeid)
);

comment on table IMAGES is
'image information';

/*==============================================================*/
/* Index: IND_PK                                                */
/*==============================================================*/
create unique index IND_PK on IMAGES (
imgeid
);

/*==============================================================*/
/* Table: LOGING_LOGS                                           */
/*==============================================================*/
create table LOGING_LOGS (
   uid                  UUID                 not null,
   userid               UUID                 not null,
   info                 VARCHAR(255)         null,
   logintime            TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   constraint PK_LOGING_LOGS primary key (uid)
);

/*==============================================================*/
/* Index: IND_USERID                                            */
/*==============================================================*/
create  index IND_USERID on LOGING_LOGS (
userid
);

/*==============================================================*/
/* Index: IND_LOGTIME                                           */
/*==============================================================*/
create  index IND_LOGTIME on LOGING_LOGS (
logintime
);

/*==============================================================*/
/* Table: USERS                                                 */
/*==============================================================*/
create table USERS (
   userid               UUID                 not null,
   userrole             UUID                 null,
   firstname            VARCHAR(50)          not null,
   lasftname            VARCHAR(50)          not null,
   username             VARCHAR(20)          not null,
   email                VARCHAR(50)          not null,
   mobile               VARCHAR(20)          not null,
   qq                   VARCHAR(12)          null,
   skype                VARCHAR(50)          null,
   facebook             VARCHAR(50)          null,
   twitter              VARCHAR(50)          null,
   wechat               VARCHAR(50)          not null,
   createby             UUID                 null,
   createts             TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   updateby             UUID                 null,
   updatets             TIMESTAMP WITH TIME ZONE null,
   constraint PK_USERS primary key (userid),
   constraint AK_USERNAME_USERS unique (username),
   constraint AK_EMAIL_USERS unique (email),
   constraint AK_MOBILE_USERS unique (mobile)
);

/*==============================================================*/
/* Index: IND_EMAIL                                             */
/*==============================================================*/
create unique index IND_EMAIL on USERS (
email
);

/*==============================================================*/
/* Index: IND_USERNAME                                          */
/*==============================================================*/
create unique index IND_USERNAME on USERS (
username
);

/*==============================================================*/
/* Index: IND_MOBILE                                            */
/*==============================================================*/
create unique index IND_MOBILE on USERS (
mobile
);

/*==============================================================*/
/* Table: USERS_ARTICALS                                        */
/*==============================================================*/
create table USERS_ARTICALS (
   uid                  UUID                 not null,
   userid               UUID                 not null,
   articalid            UUID                 not null,
   constraint PK_USERS_ARTICALS primary key (uid),
   constraint AK_USER_ARTICAL_U unique (userid, articalid)
);

/*==============================================================*/
/* Index: IND_USR_ARTICAL_ID                                    */
/*==============================================================*/
create unique index IND_USR_ARTICAL_ID on USERS_ARTICALS (
userid,
articalid
);

/*==============================================================*/
/* Table: USER_IMAGES                                           */
/*==============================================================*/
create table USER_IMAGES (
   uid                  UUID                 not null,
   userid               UUID                 not null,
   imgeid               UUID                 not null,
   createtime           TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   constraint PK_USER_IMAGES primary key (uid),
   constraint AK_UNIQUE_USER_IMAGES unique (userid, imgeid)
);

/*==============================================================*/
/* Index: IND_USER_IMG_ID                                       */
/*==============================================================*/
create  index IND_USER_IMG_ID on USER_IMAGES (
userid,
imgeid
);

/*==============================================================*/
/* Table: USER_ROLES                                            */
/*==============================================================*/
create table USER_ROLES (
   roleid               UUID                 not null,
   rolename             VARCHAR(50)          not null,
   roledesc             VARCHAR(255)         null,
   createby             UUID                 not null,
   createts             TIMESTAMP WITH TIME ZONE not null,
   updateby             UUID                 null,
   updatets             TIMESTAMP WITH TIME ZONE null,
   constraint PK_USER_ROLES primary key (roleid)
);

/*==============================================================*/
/* Index: pk                                                    */
/*==============================================================*/
create unique index pk on USER_ROLES (
roleid
);

/*==============================================================*/
/* Index: rolename                                              */
/*==============================================================*/
create  index rolename on USER_ROLES (
rolename
);

/*==============================================================*/
/* Table: USER_R_ROLES                                          */
/*==============================================================*/
create table USER_R_ROLES (
   uid                  UUID                 not null,
   userid               UUID                 not null,
   roleid               UUID                 not null,
   createby             UUID                 null,
   createts             TIMESTAMP WITH TIME ZONE null,
   updateby             UUID                 null,
   updatets             TIMESTAMP WITH TIME ZONE null,
   constraint PK_USER_R_ROLES primary key (uid),
   constraint AK_UNIQUE_USER_R_ROLES unique (userid, roleid)
);

/*==============================================================*/
/* Index: IND_USR_ROLE                                          */
/*==============================================================*/
create unique index IND_USR_ROLE on USER_R_ROLES (
userid,
roleid
);

/*==============================================================*/
/* Table: USER_R_TAGS                                           */
/*==============================================================*/
create table USER_R_TAGS (
   uid                  UUID                 not null,
   userid               UUID                 not null,
   tagid                UUID                 not null,
   createts             TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   constraint PK_USER_R_TAGS primary key (uid),
   constraint AK_UNIQUE_USER_R_TAGS unique (userid, tagid)
);

/*==============================================================*/
/* Index: USR_TAG_ID                                            */
/*==============================================================*/
create unique index USR_TAG_ID on USER_R_TAGS (
userid,
tagid
);

/*==============================================================*/
/* Table: USER_TAGS                                             */
/*==============================================================*/
create table USER_TAGS (
   tagid                UUID                 not null,
   tagname              VARCHAR(50)          not null,
   tagdes               VARCHAR(255)         null,
   createby             UUID                 null,
   createts             TIMESTAMP WITH TIME ZONE not null default CURRENT_TIMESTAMP,
   constraint PK_USER_TAGS primary key (tagid)
);

/*==============================================================*/
/* Index: IND_TAG_NAME                                          */
/*==============================================================*/
create  index IND_TAG_NAME on USER_TAGS (
tagname
);

alter table ARTICALS
   add constraint FK_ARTICALS_REF_CATEGORIES foreign key (cateid)
      references ARTICAL_CATEGORIES (cateid)
      on delete set null on update restrict;

alter table ARTICALS
   add constraint FK_ARTICALS_REF_USERS_ON_UPDATE foreign key (updateby)
      references USERS (userid)
      on delete set null on update restrict;

alter table ARTICAL_IMAGES
   add constraint FK_ARTICAL_IMAGES_FK__ARTICALS foreign key (articalid)
      references ARTICALS (articalid)
      on delete restrict on update restrict;

alter table ARTICAL_IMAGES
   add constraint FK_ARTICAL_IMAGES_FK__IMAGES foreign key (imgeid)
      references IMAGES (imgeid)
      on delete restrict on update restrict;

alter table ARTICAL_R_TAGS
   add constraint FK_ARTICAL_R_TAGS_REF_ARTICALS foreign key (articalid)
      references ARTICALS (articalid)
      on delete cascade on update restrict;

alter table ARTICAL_R_TAGS
   add constraint FK_ARTICAL_R_TAGS_REF_TAGS foreign key (tagid)
      references ARTICAL_TAGS (tagid)
      on delete cascade on update restrict;

alter table ARTICAL_TAGS
   add constraint FK_TAGES_REFERENCE_USERS foreign key (createby)
      references USERS (userid)
      on delete cascade on update restrict;

alter table COMMENTS
   add constraint FK_COMMENTS_FK__ARTICALS foreign key (articalid)
      references ARTICALS (articalid)
      on delete cascade on update restrict;

alter table COMMENTS
   add constraint FK_COMMENTS_FK__USERS foreign key (userid)
      references USERS (userid)
      on delete cascade on update restrict;

alter table COMMENT_REPLIES
   add constraint FK_COMMENT_REPLIES_FK__USERS foreign key (replyby)
      references USERS (userid)
      on delete cascade on update restrict;

alter table COMMENT_REPLIES
   add constraint FK_COMMENT_REPLIES_FK__COMMENTS foreign key (commentid)
      references COMMENTS (commentid)
      on delete cascade on update restrict;

alter table LOGING_LOGS
   add constraint FK_LOGING_LOGS_FK__USERS foreign key (userid)
      references USERS (userid)
      on delete cascade on update restrict;

alter table USERS_ARTICALS
   add constraint FK_USERS_ARTICALS_FK__ARTICALS foreign key (articalid)
      references ARTICALS (articalid)
      on delete cascade on update restrict;

alter table USERS_ARTICALS
   add constraint FK_USERS_ARTICALS_FK__USERS foreign key (userid)
      references USERS (userid)
      on delete cascade on update restrict;

alter table USER_IMAGES
   add constraint FK_USER_IMAGES_FK__IMAGES foreign key (imgeid)
      references IMAGES (imgeid)
      on delete restrict on update restrict;

alter table USER_IMAGES
   add constraint FK_USER_IMAGES_FK__USERS foreign key (userid)
      references USERS (userid)
      on delete restrict on update restrict;

alter table USER_R_ROLES
   add constraint FK_USER_R_ROLES_FK__USERS foreign key (userid)
      references USERS (userid)
      on delete cascade on update restrict;

alter table USER_R_ROLES
   add constraint FK_USER_R_ROLES_FK__USER_ROLES foreign key (roleid)
      references USER_ROLES (roleid)
      on delete cascade on update restrict;

alter table USER_R_TAGS
   add constraint FK_USER_R_TAGS_FK__USERS foreign key (userid)
      references USERS (userid)
      on delete cascade on update restrict;

alter table USER_R_TAGS
   add constraint FK_USER_R_TAGS_FK__USER_TAGS foreign key (tagid)
      references USER_TAGS (tagid)
      on delete cascade on update restrict;

alter table USER_TAGS
   add constraint FK_USER_TAGS_REFERENCE_USERS foreign key (createby)
      references USERS (userid)
      on delete cascade on update restrict;

