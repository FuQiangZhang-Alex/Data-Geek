<template>
    <div class="container-fluid">
    <form v-on:submit.prevent="onUserSubmit">
        <div v-if="this.status"
            class="alert alert-info alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
          {{this.status.retMsg}}
        </div>
        <div class="row">
            <div class="form-group col-4">
                <label for="inputUsername">User Name</label>
                <input v-model:username="newUser.user.username" type="text" class="form-control"
                    id="inputUsername"
                    aria-describedby="emailHelp"
                    placeholder="Enter User Name">
            </div>
            <div class="form-group col-4">
                <label for="exampleInputEmail1">First Name</label>
                <input v-model:firstname="newUser.user.firstname" type="text" class="form-control"
                    id="exampleInputEmail1"
                    aria-describedby="emailHelp"
                    placeholder="Enter First Name">
            </div>
            <div class="form-group col-4">
                <label for="exampleInputEmail1">Last Name</label>
                <input v-model:lastname="newUser.user.lastname" type="text" class="form-control"
                    id="exampleInputEmail1"
                    aria-describedby="emailHelp"
                    placeholder="Enter Last Name">
            </div>
        </div>
        <div class="row">
            <div class="form-group col-4">
                <label for="exampleInputEmail1">Email address</label>
                <input v-model:email="newUser.user.email" type="email" class="form-control"
                    id="exampleInputEmail1"
                    aria-describedby="emailHelp"
                    placeholder="Enter email">
                <!-- <small id="emailHelp" class="form-text text-muted">
                    We'll never share your email with anyone else.
                </small> -->
            </div>
            <div class="form-group col-4">
                <label for="exampleInputEmail1">Mobile</label>
                <input v-model:mobile="newUser.user.mobile" type="tex" class="form-control"
                    id="exampleInputEmail1"
                    aria-describedby="emailHelp"
                    placeholder="Enter mobile">
            </div>
            <div class="form-group col-4">
                <label for="exampleInputEmail1">Role</label>
                <select v-model:roleid="newUser.roleid" class="custom-select form-control">
                    <option v-for="role in roles" v-bind:value="role.roleid">{{role.rolename}}</option>
                </select>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
    </div>
</template>
<script>
    export default {
        name: 'user-form',
        props: ['roles'],
        data() {
            return {
                newUser: {
                    user: {
                        username: '',
                        firstname: '',
                        lastname: '',
                        email: '',
                        mobile: '',
                    },
                    roleid: '',
                },
                status: null
            };
        },
        methods: {
            onUserSubmit(submit) {
                // post user form to API
                const user = {
                    user: this.newUser.user,
                    role: this.findRole(this.newUser.roleid)
                };
                this.$http.post('users/', user).then(res => {
                    return res.json();
                }).then(res => {
                    this.status = res;
                    if (res.retCode === 201) {
                        this.$bus.$emit('createdUser', res.data);
                    }
                });
            },
            findRole(roleid) {
                const foundRole = this.roles.find(role => role.roleid === roleid);
                return foundRole ? foundRole : null;
            }
        },
        computed: {},
        components: {}
    }
</script>
<style scoped="scoped">
</style>