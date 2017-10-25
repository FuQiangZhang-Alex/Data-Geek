<template>
	<div class="container-fluid">
		<ArticalTagForm v-bind:users="users"></ArticalTagForm>
        <hr>
        <ArticalTagList
        v-bind:articalTags="articalTags"
        v-bind:users="users"></ArticalTagList>
	</div>
</template>
<script>
    import ArticalTagForm from '@/components/manage/ArticalTagForm';
    import ArticalTagList from '@/components/manage/ArticalTagList';
    export default {
        name: 'blog-tags',
        props: ['users', 'articalTags'],
        data() {
            return {};
        },
        methods: {},
        computed: {},
        components: {
            ArticalTagForm,
            ArticalTagList,
        }
    }
</script>
<style scoped="scoped">
</style>