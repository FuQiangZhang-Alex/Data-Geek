from rest_framework import serializers
from blogapi.models import *


class TagListSerializer(serializers.ModelSerializer):
    class Meta:
        model = ArticalTags
        fields = '__all__'


class UserListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = '__all__'


class RoleListSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserRoles
        fields = '__all__'
