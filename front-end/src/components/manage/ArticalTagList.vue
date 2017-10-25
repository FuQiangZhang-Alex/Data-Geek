<template>
    <div class="container-fluid" v-if="this.rowCount > 0">
        <table class="table table-striped">
            <thead>
                <tr class="row">
                    <th class="col-3">Tag Name</th>
                    <th class="col-3">Tag Description</th>
                    <th class="col-3">Create By</th>
                    <th class="col-3 action-header">Action</th>
                </tr>
            </thead>
            <tbody>
                <tr class="row" v-for="item in articalTags">
                    <td class="col-3">
                        {{item.tagname}}
                    </td>
                    <td class="col-3">
                        {{item.tagdes}}
                    </td>
                    <td class="col-3">
                        {{findUser(item.createby).username}}
                    </td>
                    <td class="col-3 action-header">
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
        <nav aria-label="Page navigation example" class="row justify-content-center">
            <ul class="pagination">
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Previous" v-on:click.prevent="previousPage">
                        <span aria-hidden="true">&laquo;</span>
                        <span class="sr-only">Previous</span>
                    </a>
                </li>
                <li v-for="i in pageNumberArray"
                    v-bind:class="{'page-item': true, disabled: i == page}">
                    <a class="page-link"
                        href="#"
                        v-bind:pagenumber = "i"
                        v-on:click.prevent="pageClick">{{i + 1}}</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Next" v-on:click.prevent="nextPage">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">Next</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</template>
<script>
    export default {
        name: 'tags',
        props: ['users', 'articalTags'],
        data() {
            return {
            };
        },
        methods: {
            onEdit(event) {},
            onDelete(event) {},
            findUser(userid) {
                return this.users.find(user => user.userid === userid);
            }
        },
        computed: {},
        components: {
        }
    }
</script>
<style scoped="scoped">
</style>