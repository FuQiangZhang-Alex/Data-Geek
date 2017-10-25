import Vue from 'vue';
import Router from 'vue-router';
import Home from '@/components/Home';
import Repo from '@/components/Repo';
import Blog from '@/components/blog/Blog';
import About from '@/components/About';
import Photography from '@/components/Photography';
import Manage from '@/components/manage/Manage';
import Users from '@/components/manage/Users';
import ArticalTags from '@/components/manage/ArticalTags';
import BlogCategories from '@/components/manage/BlogCategories';
import Roles from '@/components/manage/Roles';

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/home',
      redirect: {name: 'Home'}
    },
    {
      path: '/repo',
      name: 'Repo',
      component: Repo
    },
    {
      path: '/blog',
      name: 'Blog',
      component: Blog
    },
    {
      path: '/photograpy',
      name: 'Photography',
      component: Photography
    },
    {
      path: '/manage',
      component: Manage,
      children: [
        {
          path: '',
          name: 'defaultManage',
          component: Users
        },
        {
          path: 'users',
          name: 'Users',
          component: Users
        },
        {
          path: 'artical-tag',
          name: 'ArticalTags',
          component: ArticalTags
        },
        {
          path: 'blog-category',
          name: 'BlogCategories',
          component: BlogCategories
        },
        {
          path: 'roles',
          name: 'Roles',
          component: Roles
        },
      ]
    },
    {
      path: '/about',
      name: 'About',
      component: About
    },
    {
      path: '*',
      redirect: {name: 'Home'}
    },
  ]
})
