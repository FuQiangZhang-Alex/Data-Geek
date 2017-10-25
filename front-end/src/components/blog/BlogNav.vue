<template>
    <nav aria-label="breadcrumb" role="navigation">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="#">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Library</li>
  </ol>
</nav>
</template>
<script>
    export default {
        name: 'blog-nav',
        props: {
            blogCate: {
                type: String,
                required: true,
                validator: value => {
                    return true;
                }
            },
            btnLogin: {type: String, required: true}
        },
        data() {
            return {};
        },
        methods: {
            loginClick(event) {
                console.log('login');
            }
        },
        computed: {},
        components: {}
    }
</script>
<style scoped="scoped">
</style>