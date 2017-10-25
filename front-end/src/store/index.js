import Vue from 'vue';
import Vuex from 'vuex';
// import Axios from 'axios';
Vue.use(Vuex);

let languages = {
    zh: {
        btnLogin: '登陆',
        cateTile: '分类'
    },
    en: {
        btnLogin: 'Login'
    }
};

export default new Vuex.Store({
    state: {
        blogCate: 'All blogs',
        login: false,
        lang: languages.zh
    },
    mutations: {
        login(state, payload) {
            state.login = payload;
        },
        changeLang(state, payload) {
            state.lang = payload;
        }
    },
    actions: {
    }
})
