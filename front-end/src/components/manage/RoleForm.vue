<template>
   <form v-on:submit.prevent="onUserSubmit">
        <div v-if="this.status && this.status.retCode === 201"
            class="alert alert-info alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
          Role created
        </div>
        <div class="row">
            <div class="form-group col-5">
                <label for="inputRoleName">Role Name</label>
                <input v-model:rolename="newRole.rolename" type="text" class="form-control"
                    id="inputRoleName"
                    aria-describedby="emailHelp"
                    placeholder="Enter First Name">
            </div>
            <div class="form-group col-5">
                <label for="inputRoleDesc">Role Description</label>
                <input v-model:roledesc="newRole.roledesc" type="text" class="form-control"
                    id="inputRoleDesc"
                    aria-describedby="emailHelp"
                    placeholder="Enter Last Name">
            </div>
        </div>
        <button type="submit" class="btn btn-primary">{{ this.role ? 'Save' : 'Submit' }}</button>
    </form>
</template>
<script>
    export default {
        name: 'role-form',
        props: [],
        data() {
            return {
                newRole: {
                    rolename: '',
                    roledesc: ''
                },
                role: null,
                status: null,
            };
        },
        methods: {
            onUserSubmit(submit) {
                if (this.role === null) {
                    // create
                    this.$http.post('roles/', this.newRole)
                    .then(response => {
                        return response.json();
                    }, response => {return response;})
                    .then(res => {
                        this.status = res;
                        if (res.retCode === 201) {
                            this.$bus.$emit('createdRole', res.data)
                        }
                    });
                } else {
                    // update
                    this.role.rolename = this.newRole.rolename;
                    this.role.roledesc = this.newRole.roledesc;
                    this.$http.put(`roles/${this.role.roleid}/`, this.role)
                    .then(res => {
                        return res.json();
                    })
                    .then(res => {
                        this.role = null;
                        if (res.retCode === 200) {
                            this.status = res;
                            this.newRole.rolename = '';
                            this.newRole.roledesc = '';
                        }
                    }, res => {this.role = null;});
                }
            }
        },
        computed: {},
        components: {},
        created() {
            this.$bus.$on('editRole', roleToEdit => {
                if (roleToEdit) {
                    this.role = roleToEdit;
                    this.newRole.rolename = roleToEdit.rolename;
                    this.newRole.roledesc = roleToEdit.roledesc;
                }
            });
        }
    }
</script>
<style scoped="scoped">
</style>