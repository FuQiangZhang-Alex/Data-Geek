<template>
	<div>
		<RoleForm></RoleForm>
        <hr>
        <RoleList v-bind:roles="roles"></RoleList>
	</div>
</template>
<script>
    import RoleList from '@/components/manage/RoleList';
    import RoleForm from '@/components/manage/RoleForm';
    export default {
        name: 'roles',
        props: ['roles'],
        data() {
            return {};
        },
        methods: {},
        computed: {},
        components: {
            RoleList,
            RoleForm
        }
    }
</script>
<style scoped="scoped">
</style>