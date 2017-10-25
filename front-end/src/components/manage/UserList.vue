<template>
    <div class="container-fluid" v-if="this.rowCount > 0">
        <table class="table table-striped">
            <thead>
                <tr class="row">
                    <th class="col-2">username</th>
                    <th class="col-4">email</th>
                    <th class="col-3">mobile</th>
                    <th class="col-3 action-header">action</th>
                </tr>
            </thead>
            <tbody>
                <tr class="row" v-for="item in this.pageContent">
                    <td class="col-2">
                        {{item.username}}
                    </td>
                    <td class="col-4">
                        {{item.email}}
                    </td>
                    <td class="col-3">
                        {{item.mobile}}
                    </td>
                    <td class="col-3 action-header">
                        <button v-bind:roleid="item.userid"
                            v-on:click.prevent="onEdit" type="button"
                            class="btn btn-primary">Edit</button>
                        <button v-bind:roleid="item.userid"
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
    import UserAPI from '@/utils/api';
    export default {
        name: 'user-list',
        props: ['users'],
        data() {
            return {
                pagesize: this.$pagesize,
                page: 0,
            };
        },
        methods: {
            onEdit(event) {},
            onDelete(event) {},
            previousPage(event) {
                if(this.page >= 1) {
                    this.page -= 1;
                }
            },
            nextPage(event) {
                if(this.page < (this.pageCount - 1)) {
                    this.page += 1;
                }
            },
            pageClick(event) {
                const pageNumber = event.target.getAttribute('pagenumber');
                if (pageNumber && pageNumber !== NaN) {
                    this.page = pageNumber;
                }
            }

        },
        computed: {
            pageCount() {
                const pc = Math.ceil(this.rowCount / this.pagesize);
                return pc;
            },
            pageNumberArray() {
                let pagers = [];
                if (this.pageCount > 0) {
                    for(let i = 0; i < this.pageCount; i++) {
                        pagers.push(i);
                    }
                }
                return pagers;
            },
            rowCount() {
                return this.users.length;
            },
            pageContent() {
                const begin = this.page * this.pagesize;
                const end = begin + this.pagesize;
                return this.users.slice(begin, end);
            }
        },
        components: {
        },
    }
</script>
<style scoped="scoped">
</style>