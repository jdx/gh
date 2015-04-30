$(document).ready(function () {
    var uri = 'gh://' + document.documentURI.replace("https://github.com/", "");
    var link = $('<a href="' + uri + '">Clone with GH</a>');
    link.addClass('btn btn-sm sidebar-button')
        .attr({
            "aria-label": 'Clone with GH',
            title: 'Clone with GH'
        }).prepend('<span class="octicon octicon-cloud-download">');

    $(".only-with-full-nav")
        .append(link);


});