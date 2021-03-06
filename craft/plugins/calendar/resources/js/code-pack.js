var $prefix = $('#prefix');
var $components = $('#components-wrapper');
var firstFileLists = $('> div > ul.directory-structure', $components);

var prefixTimeout = null;

$(function(){
    $prefix.on({
        keyup: function(e) {
            clearTimeout(prefixTimeout);
            prefixTimeout = setTimeout(function(){ 
                updateFilePrefixes();
            }, 50);
        }
    });

    updateFilePrefixes();
});

function updateFilePrefixes()
{
    firstFileLists.each(function(){
        var $fileList = $(this);
        $('> li > span[data-name]', $fileList).each(function(){
            $(this).html($prefix.val() + $(this).data('name'));
        });
    });
}
