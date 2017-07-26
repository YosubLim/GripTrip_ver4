$(document).ready(function () {
    //Initialize tooltips
    $('.nav-tabs > li a[title]').tooltip();
    
    //Wizard
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {

        var $target = $(e.target);
    
        if ($target.parent().hasClass('disabled')) {
            return false;
        }
    });

    $(".next-step").click(function (e) {
        var $active = $('.wizard .nav-tabs li.active');
        $active.next().removeClass('disabled');
        nextTab($active);
    });
    $(".prev-step").click(function (e) {

        var $active = $('.wizard .nav-tabs li.active');
        prevTab($active);

    });
    $('#all-save').click(function () {    	
		var cover = $('input[type=radio][name=cover]:checked').val();	
		var size = $('input[type=radio][name=size]:checked').val();
		var paper = $('input[type=radio][name=paper]:checked').val();
		if(cover==null || size==null || paper==null){
			alert("옵션을 모두 선택해주세요")
			var $active = $('.wizard .nav-tabs li.active');
			prevTab($active);
			return;
		}
		cover = Number(cover);
		size = Number(size);
		paper = Number(paper);
		
		$('#selected').html(cover+size+paper);
	});
});

function nextTab(elem) {
    $(elem).next().find('a[data-toggle="tab"]').click();
}
function prevTab(elem) {
    $(elem).prev().find('a[data-toggle="tab"]').click();
}