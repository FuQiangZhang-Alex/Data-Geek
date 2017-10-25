<template>
    <table class="table table-striped">
        <thead>
            <tr class="row"><th class="col-4">role name</th><th class="col-4">role description</th><th class="col-4 action-header">action</th></tr>
        </thead>
        <tbody>
            <tr class="row" v-for="item in roles">
                <td class="col-4">
                    {{item.rolename}}
                </td>
                <td class="col-4">
                    {{item.roledesc}}
                </td>
                <td class="col-4 action-header">
                    <button v-bind:roleid="item.roleid"
                        v-on:click.prevent="onEdit" type="button"
                        class="btn btn-primary">Edit</button>
                    <button v-bind:roleid="item.roleid"
                        v-on:click.prevent="onDelete" type="button"
                        class="btn btn-danger">Delete</button>
                </td>
            </tr>
        </tbody>
    </table>
</template>
<script>
    export default {
        name: 'role-list',
        props: ['roles'],
        data() {
            return {
                page: 0
            };
        },
        methods: {
            onEdit(event) {
                const roleid = event.target.getAttribute('roleid');
                this.$bus.$emit('editRole', this.roles.find(role => role.roleid === roleid));
            },
            onDelete(event) {
                // delete role
                const roleid = event.target.getAttribute('roleid');
                this.$http.delete(`roles/${roleid}/`)
                    .then(success => {
                        return success.json();
                    })
                    .then(success => {
                        this.removeDeletedRole(roleid);
                    },fail => {console.log('fail');});
            },
            removeDeletedRole(roleid) {
                this.$bus.$emit('deleteRole', roleid);
            }
        },
        computed: {
            rowCount() {
                return this.roles.length;
            }
        },
        components: {},
    }
</script>
<style scoped="scoped">
</style>