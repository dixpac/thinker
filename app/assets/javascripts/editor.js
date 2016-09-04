var Editor = {
  init: function() {
    /*** Simply return if it's not editor page ***/
    if (!$('[data-page="main-editor"]').length > 0) {
      return;
    }

    var editor = new MediumEditor('.medium-editable', {
      placeholder: {
        text: "Tell your Story ..."
      }
    });

    $('.medium-editable').mediumInsert({
      editor: editor,
      addons: {
        images: {
          fileUploadOptions: { // TODO: figure out how to upload pictures to AS3
            url: $('.editor-form').attr('action'),
            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
            method: 'PATCH'
          }
        },
        embeds: {
          oembedProxy: null
        }
      }
    });

    // FIXME: is there a better way to do this?
    $('[data-behavior="publish-button"').hover(function() {
    });

    $("#story_picture").change(function(){
      Editor.readURL(this);
      $('#existing-img-previewer').addClass('hidden');
      $('.picture_upload').addClass('active');
      $('.file-upload-previewer').removeClass('hidden');
    });

    /*** Autosave ***/
    $('[data-behavior="autosave"]').autoSave(function() {
      $('[data-behavior="editor-message"]').text('Saving...');
      Editor.storyAutosave($('.editor-form').attr('action'),
                   $('input[name="_method"]').val(),
                   $('#story_title').val(),
                   $('#story_body').val()
                  );
    }, 500);

    /*** Form submit ***/
    $('[data-behavior="publish-button"]').on('click', function() {
      $('.editor-form').submit();
    });

    $('.publish-dropdown').on('click', function(e) {
      e.stopPropagation();
    });

  }, 

  readURL: function(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#image_preview').attr('src', e.target.result);
      }

      reader.readAsDataURL(input.files[0]);
    }
  },

  storyAutosave: function(url, method, title, body) {
    $.ajax({
      url: '/api' + url,
      dataType: "script",
      method: method || "POST",
      data: {
        story: {
          title: title,
          body: body
        }
      },
      success: function() { console.log('autosave successful'); }
    });
  }

};

$(document).ready( Editor.init );
$(document).on( 'page:load', Editor.init );
