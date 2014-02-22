$('form input[type != "submit"]').addClass("default-value")

$('.default-value').each(function() {
    var default_value = this.value;
    $(this).focus(function() {
        if(this.value == default_value) {
            this.value = '';
        }
    });
    $(this).blur(function() {
        if(this.value == '') {
            this.value = default_value;
        }
    });
});

$('#remove').on('click', function (e) {
    e.preventDefault();
    $('.row.item').remove();
});
