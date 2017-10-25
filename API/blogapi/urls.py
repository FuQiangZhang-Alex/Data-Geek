from django.conf.urls import url
from blogapi import views

urlpatterns = [
    url(regex='^artical-tags/$',
        view=views.ArticalTagList.as_view(),
        name=views.ArticalTagList.name),
    url(regex='^users/$',
        view=views.UserList.as_view(),
        name=views.UserList.name),
    url(regex='^roles/$',
        view=views.RoleList.as_view(),
        name=views.RoleList.name),
    url(regex=r'^roles/(?P<pk>[a-z\d]{8}-[a-z\d]{4}-[a-z\d]{4}-[a-z\d]{4}-[a-z\d]{12})/$',
        view=views.RoleList.as_view(),
        name=views.RoleList.name),
]
