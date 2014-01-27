//= require fineuploader/jquery.fineuploader-4.1.0

$(document).ready(function () {
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
    }).on('complete', function(event, id, filename) {
        $("#uploadComplete").modal('show');
    });
});