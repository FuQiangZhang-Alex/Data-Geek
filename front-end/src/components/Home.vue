<template>
  <div class="container-fluid">
    home
  </div>
</template>

<script>
    export default {
    name: 'home',
    data () {
      return {
        msg: 'Welcome to Your Vue.js App',
        news: [
          {id: 1, author: 'alex', ts: this.$moment().format('YYYY-MM-DD HH:mm:ss'), title: 'news on Cognitive', content: 'xxxx'},
          {id: 1, author: 'alex', ts: this.$moment().format('YYYY-MM-DD HH:mm:ss'), title: 'news on Cognitive', content: 'xxxx'},
          {id: 1, author: 'alex', ts: this.$moment().format('YYYY-MM-DD HH:mm:ss'), title: 'news on Cognitive', content: 'xxxx'},
          {id: 1, author: 'alex', ts: this.$moment().format('YYYY-MM-DD HH:mm:ss'), title: 'news on Cognitive', content: 'xxxx'},
          {id: 1, author: 'alex', ts: this.$moment().format('YYYY-MM-DD HH:mm:ss'), title: 'news on Cognitive', content: 'xxxx'},
          {id: 1, author: 'alex', ts: this.$moment().format('YYYY-MM-DD HH:mm:ss'), title: 'news on Cognitive', content: 'xxxx'},
        ]
      }
    },
    mounted() {
      // $('.collapsible').collapsible();
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.title {
  margin-top: 5px;
}
</style>
