document.addEventListener('turbolinks:load', function() {
  var Image = document.querySelector('.picture-image');

  function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail.
          var span = document.createElement('span');
          span.innerHTML = [
            '<img class="picture-preview-thumb" src="',
            e.target.result,
            '" title="',
            escape(theFile.name),
            '"/>'
          ].join('');
          var image = document.getElementById('image');
          image.innerHTML = '';
          image.insertBefore(span, null);
        };
      })(f);
      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }
  }

  if (Image) {
    Image.addEventListener('change', handleFileSelect, false);
  }

});

