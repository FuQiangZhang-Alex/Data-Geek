<template>
    <div class="container-fluid">
        <div class="row">
            <div class="col-2">
                Category:
            </div>
            <div class="col-10">
                <blog-list :blogList="blogList"></blog-list>
            </div>
        </div>
    </div>
</template>
<script>
    import BlogList from '@/components/blog/BlogList';
    import BlogCategory from '@/components/blog/BlogCategory';
    import BlogStatistics from '@/components/blog/BlogStatistics';
    import BlogRecomend from '@/components/blog/BlogRecomend';
    import BlogTopReadings from '@/components/blog/BlogTopReadings';
    import BlogTags from '@/components/blog/BlogTags';
    import BlogNav from '@/components/blog/BlogNav';
    export default {
        name: 'blog',
        props: [],
        data() {
            return {
                tagName: 'tag',
                blogList: [
                    {title: 'abc'},
                    {title: 'dec'},
                    {title: 'gty'},
                    {title: 'rfv'},
                ],
            };
        },
        methods: {},
        computed: {},
        components: {
            BlogList,
            BlogCategory,
            BlogTags,
            BlogStatistics,
            BlogRecomend,
            BlogTopReadings,
            BlogNav
        }
    }
</script>
<style scoped="scoped">
    div.v-divider {
        margin-left:5px;
        margin-right:5px;
        width:1px;
        height:100%;
        border-left:1px solid gray;
    }
</style>