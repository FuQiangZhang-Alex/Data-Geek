<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">
            <img src="static/img/logo.svg" width="30" height="30" alt="">
            Data Geek
  </a>
  <button class="navbar-toggler" type="button"
          data-toggle="collapse" data-target="#navbarNavDropdown"
          aria-controls="navbarNavDropdown" aria-expanded="false"
          aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavDropdown">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <router-link class="nav-link" v-bind:to="{name: 'Home'}">{{messages.home}}</router-link>
      </li>
      <li class="nav-item">
        <router-link class="nav-link" v-bind:to="{name: 'Repo'}">{{messages.repo}}</router-link>
      </li>
      <li class="nav-item">
        <router-link class="nav-link" v-bind:to="{name: 'Blog'}">{{messages.blog}}</router-link>
      </li>
      <li class="nav-item">
        <router-link class="nav-link" v-bind:to="{name: 'Photography'}">{{messages.photography}}</router-link>
      </li>
      <li class="nav-item">
        <router-link class="nav-link" v-bind:to="{name: 'defaultManage'}">{{messages.manage}}</router-link>
      </li>
      <li class="nav-item">
        <router-link class="nav-link" v-bind:to="{name: 'About'}">{{messages.about}}</router-link>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="http://example.com" id="lang_dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          {{messages.lang}}
        </a>
        <div class="dropdown-menu" aria-labelledby="lang_dropdown">
          <a class="dropdown-item" href="#" v-on:click="handleLangSelect">English</a>
          <a class="dropdown-item" href="#" v-on:click="handleLangSelect">简体中文</a>
        </div>
      </li>
    </ul>
  </div>
</nav>
</template>
<script>
    export default {
        name: 'nav-bar',
        data() {
          return {
            messages: this.$locale.messages,
            lang: this.$locale.language,
            currency: this.$locale.currency
          };
        },
        methods: {
          handleLangSelect(event) {
            event.preventDefault();
          }
        },
        mounted() {
          // console.log($(".dropdown-button").dropdown);
          // $(".dropdown-button").dropdown();
        }
    }
</script>
<style scoped="scoped">
</style>