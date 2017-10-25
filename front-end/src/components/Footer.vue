<template>
    <footer class="page-footer">
        <div class="footer-copyright">
            <div class="container">
            © {{currentYear}} Copyright Data Geek.
            </div>
        </div>
    </footer>
</template>
<script>
    export default {
        name: 'footer',
        props: ['currentYear']
    }
</script>
<style scoped="scoped">
    footer {
        padding-top: 0;
    }
</style>