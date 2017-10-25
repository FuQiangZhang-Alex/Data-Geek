<template>
  <div id="app" class="container-fluid">
    <nav-bar></nav-bar>
    <router-view></router-view>
    <!-- <my-footer v-bind:currentYear="currentYear"></my-footer> -->
  </div>
</template>

<script>
    import NavBar from '@/components/NavBar';
    export default {
        name: 'app',
        data() {
            return {
                currentYear: this.$moment().format('YYYY'),
            };
        },
        components: {
            NavBar
        }
    }
</script>

<style>
    button {
        cursor: pointer;
    }
    .action-header {
        text-align: center;
    }
</style>
