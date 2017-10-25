<template>
    <div class="container-fluid">
        <UserForm v-bind:roles="roles"></UserForm>
        <UserList
            v-bind:users="users"></UserList>
    </div>
</template>
<script>
    import UserList from '@/components/manage/UserList';
    import UserForm from '@/components/manage/UserForm';
    export default {
        name: 'users',
        props: ['users', 'roles'],
        data() {
            return {
            };
        },
        methods: {},
        computed: {},
        components: {
            UserList,
            UserForm
        }
    }
</script>
<style scoped="scoped">
</style>