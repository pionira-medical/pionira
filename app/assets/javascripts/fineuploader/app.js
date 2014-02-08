//= require fineuploader/jquery.fineuploader-4.1.0

$(document).ready(function () {
    var filesToUpload = 0;
    var filesUploaded = 0;

    $('#uploadComplete button').click(function() {
      location.reload();
    });
    $("#uploader").fineUploader({
        request: {
            endpoint: '/'+$('#order_id').val()+'/daten',
            params: {
                authenticity_token: $('meta[name=csrf-token]').attr('content')
            }
        },
        maxConnections: 2,
        template: 'qq-template-bootstrap',
        classes: {
            success: 'alert alert-success',
            fail: 'alert alert-error'
        }
    }).on('submitted', function(event, id, filename) {
        if (filesToUpload == 0) {
          $("#uploadProgress").modal('show');
        }
        filesToUpload++;               
    }).on('complete', function(event, id, filename) {
        filesUploaded++;
        $("li.qq-file-id-"+id).remove();
        if (filesUploaded == filesToUpload) {
          $("#uploadProgress").modal('hide');
          $("#uploadComplete").modal('show');
        } else {
          var progress = filesUploaded / (filesToUpload / 100)
          if (progress > 15) {
            $("#uploadProgress .progress-bar").css('width', progress+'%');
          }
        }
    });
});