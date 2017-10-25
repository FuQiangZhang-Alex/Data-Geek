<template>
    <div class="chip">
        {{tagName}}
        <!-- <i class="close material-icons">close</i> -->
    </div>
</template>
<script>
    export default {
        name: 'blog-tags',
        props: ['tagName'],
        data() {
            return {};
        },
        methods: {},
        computed: {},
        components: {}
    }
</script>
<style scoped="scoped">
</style>