
 const UserAPI = {
    fetchUsers() {
        let page = {pagesize: this.$pagesize, page: this.page}
        this.$http.get('users/')
        .then(res => { return res.json(); }, res => { return res; })
        .then(res => {
            this.users = res.data;
        }, res => { console.log('fail'); });
    }
};

export default UserAPI;
