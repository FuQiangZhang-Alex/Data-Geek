// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue';
import App from './App';
import router from './router';
import store from './store';

// locale import
import Locale from '@/locale/locales';
Object.defineProperty(Vue.prototype, '$locale', { get() { return Locale } });

import moment from 'moment-timezone';
Object.defineProperty(Vue.prototype, '$moment', { get() { return moment } });

import VueResource from 'vue-resource';
Vue.use(VueResource);
Vue.http.options.root = 'http://127.0.0.1:8000/';
// Vue.http.options.credentials = true;

// import { checkFilter, setDay } from './util/bus';
const bus = new Vue();
Object.defineProperty(Vue.prototype, '$bus', { get() {return bus;} });

import Vuex from 'vuex';
Vue.use(Vuex);

// set page size
const PAGE_SIZE = 5;
Object.defineProperty(Vue.prototype, '$pagesize', { get() {return PAGE_SIZE;} });

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App },
  store
})
