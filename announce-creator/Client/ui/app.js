var app = new Vue({
    el: '#app',
    data: {
        opened: false,
        job : null,
        page: 'create',
        presets: null,
        value: null
    },
    methods: {
        setPage: function(string){
            this.page = string 
        },
        sendAlert: function(){
           let string = $("#text-input").val()
            let obj = {
                msg : string
            }    
            $.post('https://announce-creator/send', JSON.stringify({obj}));
        },
        sendPresetAnnounce: function(obj) {
            $.post('https://announce-creator/send', JSON.stringify({obj}));
        }
    }
})
$(function () {
    $(".bloque-anuncio").hide()
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://announce-creator/exit', JSON.stringify({}));
            app.opened = false
            return
        }
    };
    window.addEventListener("message", function(event){
        const v = event.data;
        if (v.action == "anuncio") {
            app.opened = true
            app.presets = v.presets
            app.job = v.job
        } else if (v.action = 'execute'){
            let duration = 4
            $(".anuncio").text(event.data.content.msg)
            $(".bloque-anuncio").fadeIn(200)
            if (app.job == 'police') {
                $(".bloque-header").text('POLICIA')
            } else if (app.job == 'ambulance') {
                $(".bloque-header").text('EMS')
            } else if (app.job == 'mechanic') {
                $(".bloque-header").text('MECANICO')
            }
            setTimeout(() => {
                $(".bloque-anuncio").fadeOut(200)
            }, duration * 1000);
        } else {
            app.opened = false
        }
    });
});
