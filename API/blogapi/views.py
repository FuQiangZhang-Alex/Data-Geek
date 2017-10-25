
from rest_framework.views import APIView
from rest_framework.response import Response
# from django.http import HttpResponse
from blogapi.serializers import *
from blogapi.models import *
# from rest_framework.settings import api_settings
from blogapi.utils import retMsg

import logging
logger = logging.getLogger(__name__)


class ArticalTagList(APIView):
    name = 'get_blog_tag_list'

    def get(self, request):
        res = retMsg()
        data = tuple(TagListSerializer(ArticalTags.objects.all(), many=True).data)
        res.update(data=data)
        return Response(data=res.data)

    def post(self, request):
        res = retMsg()
        data = dict(request.data)
        new_tag = ArticalTags(**data['tag'])
        ref_user = Users(**data['user'])
        new_tag.createby = ref_user
        try:
            new_tag.clean_fields()
            new_tag.clean()
            new_tag.save()
        except Exception as e:
            logger.debug(str(e))
            res.update(code=401, msg='invalid input')
        else:
            res.update(code=201, msg='created')
        return Response(data=res.data)


class UserList(APIView):
    name = 'user_list'

    def get(self, request):
        res = retMsg()
        data = tuple(UserListSerializer(Users.objects.all(), many=True).data)
        res.update(data=data)
        return Response(data=res.data)

    def post(self, request):
        res = retMsg()
        data = dict(request.data)
        new_user = Users(**data['user'])
        role = UserRoles(**data['role'])
        try:
            new_user.clean_fields()
            new_user.clean()
            new_user.validate_unique(exclude=['firstname', 'lastname', 'qq',
                                              'skype', 'facebook', 'twitter', 'wechat',
                                              'createts', 'updatets'])
            new_user.save()
            new_UR = UserRRoles(
                userid=new_user,
                roleid=role
            )
            new_UR.save()
        except Exception as e:
            res.update(code=401, msg='invalid input')
            # raise e
        else:
            res.update(data=UserListSerializer(new_user).data, code=201, msg='created')
        return Response(data=res.data)


class RoleList(APIView):
    name = 'role-list'

    def get(self, request):
        res = retMsg()
        data = RoleListSerializer(UserRoles.objects.all(), many=True).data
        res.update(data=data)
        return Response(data=res.data)

    def post(self, request):
        res = retMsg()
        data = dict(request.data)
        newRole = UserRoles(**(data))
        try:
            # newRole.clean_fields()
            # newRole.clean()
            newRole.save(force_insert=True)
        except Exception as e:
            raise e
        else:
            res.update(data=RoleListSerializer(newRole).data, code=201, msg='created')
        return Response(data=res.data)

    def put(self, request, pk):
        res = retMsg()
        if request.data:
            newRole = UserRoles(**request.data)
            try:
                newRole.save()
            except Exception as e:
                raise e
            else:
                res.update(msg='updated')
        else:
            res.update(code=401, msg='invalid input')
        return Response(data=res.data)

    def delete(self, request, pk):
        res = retMsg()
        if pk:
            try:
                roleToDelete = UserRoles.objects.get(pk=pk)
                roleToDelete.delete(keep_parents=True)
            except Exception as e:
                raise e
            else:
                res.update(msg='deleted')
        else:
            res.update(code=401, msg='invalid input')
        return Response(data=res.data)
