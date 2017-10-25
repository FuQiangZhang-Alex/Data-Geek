<template>
    <form v-on:submit.prevent="onUserSubmit">
        <div v-if="this.httpStatus && this.httpStatus.retCode === 201"
            class="alert alert-info alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
          Artical Tag created
        </div>
        <div class="row">
            <div class="form-group col-4">
                <label for="inputRoleName">Tag Name</label>
                <input v-model:tagname="newTag.tag.tagname" type="text" class="form-control"
                    id="inputRoleName"
                    aria-describedby="emailHelp"
                    placeholder="Enter First Name">
            </div>
            <div class="form-group col-4">
                <label for="inputRoleDesc">Tag Description</label>
                <input v-model:tagdes="newTag.tag.tagdes" type="text" class="form-control"
                    id="inputRoleDesc"
                    aria-describedby="emailHelp"
                    placeholder="Enter Last Name">
            </div>
            <div class="form-group col-4">
                <label for="exampleInputEmail1">Create By</label>
                <select v-model:roleid="newTag.userid" class="custom-select form-control">
                    <option v-for="user in users" v-bind:value="user.userid">{{user.username}}</option>
                </select>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">{{ this.currentTag ? 'Save' : 'Submit' }}</button>
    </form>
</template>
<script>
    export default {
        name: 'blog-tag-form',
        props: ['users'],
        data() {
            return {
                newTag: {
                    tag: {
                        tagname: '',
                        tagdes: '',
                    },
                    userid: ''
                },
                user: null,
                currentTag: null,
                httpStatus: null
            };
        },
        methods: {
            onUserSubmit(submit) {
                const user = this.users.find(u => u.userid === this.newTag.userid);
                const tag = this.newTag.tag;
                this.$http.post('artical-tags/', {user: user, tag: tag})
                    .then(success => {
                        return success.json();
                    })
                    .then(success => {
                        this.httpStatus = success;
                        if (success.retCode === 201) {
                            this.$bus.$emit('createdArticalTag', success.data);
                        }
                    }, fail => {console.log('fail');});
            }
        },
        computed: {},
        components: {}
    }
</script>
<style scoped="scoped">
</style>