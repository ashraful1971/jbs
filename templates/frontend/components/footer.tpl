    </div>
    <!-- footer start -->
    <footer>
        <p class="p-3 bg-white text-gray-700 text-center box-shadow mt-20">Copyright 2021. All right reserved</p>
    </footer>
    {load_script context="frontend"}

    {call_hook name="Templates::Common::Footer::PageFooter"}
    
    {* menu toggle script *}
    <script>
        $(document).ready(()=>{
            $(".menu-toggler").click((e)=>{
                e.preventDefault();
                $(".main-nav-menu").toggle(300);
            });
        });
    </script>
</body>

</html>