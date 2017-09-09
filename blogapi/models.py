from django.db import models
import uuid


# Create your models here.
class Images(models.Model):
    image_id = models.UUIDField(primary_key=True, default=uuid.uuid4(), editable=False)
    create_timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        tb_name = 'IMAGES'
        managed = False


class Articals(models.Model):
    artical_id = models.UUIDField(primary_key=True, default=uuid.uuid4(), editable=False)
    user_id = models.ForeignKey(users, on_delete=models.CASCADE, related_name='user_id')
