jQuery(document).ready(function () {
        var $container = $('#ListFavoritesContainer');
        $container.imagesLoaded(function () {
            $container.masonry({
                itemSelector:'.masonryImage',
                // isAnimated:true,
                // animationOptions:{
                //     duration:750,
                //     easing:'linear',
                //     queue:false
                // }
            });
        });
    })
