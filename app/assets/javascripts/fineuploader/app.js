//= require fineuploader/jquery.fineuploader-4.1.0

function createUploader() {
    var uploader = new qq.FineUploader({
        element: document.getElementById('uploader'),
        request: {
            endpoint: '/orders/'+$('#order_id').val()+'/images',
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
    });
}

window.onload = createUploader;