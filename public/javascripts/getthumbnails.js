function processURL(url, success){
var id;

if (url.indexOf('youtube.com') > -1) {
    <!-- CHANGED -->
    id = url.split('v=')[1].split('&')[0];
    return processYouTube(id);
} else if (url.indexOf('youtu.be') > -1) {
    id = url.split('/')[1];
    return processYouTube(id);
} else if (url.indexOf('vimeo.com') > -1) {
    <!-- CHANGED -->
    if (url.match(/^vimeo.com\/(\d+)($|\/)/)) {
        id = url.split('/')[1];
    } else if (url.match(/^vimeo.com\/channels\/[\d\w]+#[0-9]+/)) {
        id = url.split('#')[1];
    } else if (url.match(/vimeo.com\/groups\/[\d\w]+\/videos\/[0-9]+/)) {
        id = url.split('/')[4];
    } else {
        throw new Error('Unsupported Vimeo URL');
    }

    $.ajax({
        url: 'http://vimeo.com/api/v2/video/'+id+'.json',
        dataType: 'jsonp',
        success: function(data) {
            <!-- CHANGED -->
             success(data[0].thumbnail_medium);
        }
    });
} else {
    throw new Error('Unrecognised URL');
}

function processYouTube(id) {
    if (!id) {
        throw new Error('Unsupported YouTube URL');
    }
    <!-- CHANGED -->
    success('http://i2.ytimg.com/vi/' + id + '/hqdefault.jpg');
}
}
