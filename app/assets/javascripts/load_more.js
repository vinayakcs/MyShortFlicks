$(function() {

var utils=msf_utils();
init=function(){
$('#load_more_link').attr('href',utils.setLoadMoreParam(document.location.search));
};

init();

});
