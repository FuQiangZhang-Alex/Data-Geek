<template>
	<div>
		<ul>
            <li v-for="blog in blogList">
                <BlogItem v-bind:blog="blog"></BlogItem>
            </li>
        </ul>
	</div>
</template>
<script>
    import BlogItem from '@/components/blog/BlogItem';

    export default {
        name: 'blog-list',
        props: ['blogList'],
        data() {
            return {};
        },
        methods: {},
        computed: {},
        components: {
            BlogItem
        }
    }
</script>
<style scoped="scoped">
</style>