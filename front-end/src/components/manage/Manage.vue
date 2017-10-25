<template>
        <div class="container-fluid">
            <h4>Manage</h4>
            <div class="row">
                <div class="col-3">
                    <div class="list-group" id="list-tab" role="tablist">
                        <router-link v-bind:to="{name: 'Users'}"
                            v-on:click=""
                            class="list-group-item list-group-item-action"
                            data-toggle="list"
                            role="tab">
                            {{messages.managePage.user}}
                        </router-link>
                        <router-link v-bind:to="{name: 'Roles'}"
                            v-on:click=""
                            class="list-group-item list-group-item-action"
                            data-toggle="list"
                            role="tab">
                            {{messages.managePage.role}}
                        </router-link>
                        <router-link v-bind:to="{name: 'ArticalTags'}"
                            v-on:click=""
                            class="list-group-item list-group-item-action"
                            data-toggle="list"
                            role="tab">
                            {{messages.managePage.blogTag}}
                        </router-link>
                        <router-link v-bind:to="{name: 'BlogCategories'}"
                            v-on:click=""
                            class="list-group-item list-group-item-action"
                            data-toggle="list"
                            role="tab">
                            {{messages.managePage.blogCategory}}
                        </router-link>
                    </div>
                </div>
                <div class="col-9">
                    <router-view
                     v-bind:users="this.users"
                     v-bind:roles="this.roles"
                     v-bind:articalTags="articalTags"></router-view>
                </div>
            </div>
        </div>
</template>
<script>
    export default {
        name: 'manage',
        props: [],
        data() {
          return {
            messages: this.$locale.messages,
            lang: this.$locale.language,
            currency: this.$locale.currency,
            roles: [],
            users: [],
            articalTags: [],
            page: 0,
          };
        },
        methods: {
            fetchUsers() {
                let page = {pagesize: this.$pagesize, page: this.page}
                this.$http.get('users/')
                .then(res => { return res.json(); }, res => { return res; })
                .then(res => {
                    this.users = res.data;
                }, res => { console.log('fail'); });
            },
            fetchRoles() {
                this.$http.get('roles/')
                .then(res => { return res.json(); }, res => { return res; })
                .then(res => {
                    this.roles = res.data;
                }, res => { console.log('fail'); });
            },
            fetchArticalTags() {
                let page = 0;
                this.$http.get('artical-tags/')
                .then(res => { return res.json(); }, res => { return res; })
                .then(res => {
                    this.articalTags = res.data;
                }, res => { console.log('fail'); });
            }
        },
        computed: {
        },
        components: {},
        beforeMount() {
            if (this.users.length === 0) {
                this.fetchUsers();
            }
            if(this.roles.length === 0) {
                this.fetchRoles();
            }
            if (this.articalTags.length === 0) {
                this.fetchArticalTags();
            }
            this.$bus.$on('createdUser', (createdUser) => {
                const exists = this.users.find(user => user.userid === createdUser.userid);
                if ( ! exists ) {
                    this.users.push(createdUser);
                }
            });
            this.$bus.$on('createdRole', (createdRole) => {
                const exists = this.roles.find(role => role.roleid === createdRole.roleid);
                if ( ! exists ) {
                    this.roles.push(createdRole);
                }
            });
            this.$bus.$on('deleteRole', (deletedRoleId) => {
                const remainingRoles = this.roles.filter(role => role.roleid !== deletedRoleId);
                this.roles = remainingRoles;
            });
        },
    }
</script>
<style scoped="scoped">
</style>