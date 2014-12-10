docReady( function() {

  var container = document.querySelector('.packery');
  var pckry;
  
  imagesLoaded( container, function() {
    pckry = new Packery( container, {
      columnWidth: '.grid-sizer',
      rowHeight: '.grid-sizer',
      itemSelector: '.item'
    });
  });

});



