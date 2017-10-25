from django.db import models
import uuid


class Users(models.Model):
    userid = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    firstname = models.CharField(max_length=50)
    lastname = models.CharField(max_length=50)
    username = models.CharField(max_length=20, unique=True)
    email = models.CharField(max_length=50, unique=True)
    mobile = models.CharField(max_length=20, unique=True)
    qq = models.CharField(max_length=12, blank=True)
    skype = models.CharField(max_length=50, blank=True)
    facebook = models.CharField(max_length=50, blank=True)
    twitter = models.CharField(max_length=50, blank=True)
    wechat = models.CharField(max_length=50, blank=True)
    createts = models.DateTimeField(auto_now_add=True)
    updatets = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "users"
        managed = False


class UserRoles(models.Model):
    roleid = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    rolename = models.CharField(max_length=50)
    roledesc = models.CharField(max_length=255)
    createts = models.DateTimeField(auto_now_add=True)
    updatets = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "user_roles"
        managed = False


class UserRRoles(models.Model):
    uid = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    userid = models.ForeignKey(
        to=Users, db_column='userid', on_delete=models.CASCADE
    )
    roleid = models.ForeignKey(
        to=UserRoles, db_column='roleid', on_delete=models.CASCADE
    )
    createts = models.DateTimeField(auto_now_add=True)
    updatets = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'user_r_roles'
        managed = False


class ArticalTags(models.Model):
    tagid = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    tagname = models.CharField(max_length=50)
    tagdes = models.CharField(max_length=250)
    createby = models.ForeignKey(to=Users, related_name='tag_userid',
                                 db_column='createby', on_delete=models.CASCADE,
                                 to_field='userid')
    createts = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'artical_tags'
        managed = False


class Images(models.Model):
    image_id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    create_timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'images'
        managed = False


class Articals(models.Model):
    artical_id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user_id = models.ForeignKey(Users, on_delete=models.CASCADE, related_name='user_id')

    class Meta:
        db_table = 'articals'
        managed = False
