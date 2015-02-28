// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//= require psswrd

window.$zopim||(function(d,s){var z=$zopim=function(c){z._.push(c)},$=z.s=
d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o){z.set.
_.push(o)};z._=[];z.set._=[];$.async=!0;$.setAttribute('charset','utf-8');
$.src='//v2.zopim.com/?2nCZyQlWjrA1MXoaSq655bHykyjEpkH2';z.t=+new Date;$.
type='text/javascript';e.parentNode.insertBefore($,e)})(document,'script');


(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-54746650-2', 'auto');
ga('send', 'pageview');


$(document).ready(function(){
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })


  $(".scroll-link").click(function(e) {
    var section;
    e.preventDefault();
    section = $(this).attr("href");
    return $("html, body").animate({
      scrollTop: $(section).offset().top
    }, 1000);
  });

  $("#landing").click(function() {
    $.ajax({
      url: 'count1',
      data: {
          value: $(this).val()
      },
      type: "GET",
      success: function(data) {
        var a = parseInt(data);
        $('#display1').css('display', 'none');
        $('#landing_count').html('<p>'+a+'</p>');
      }
    });
  });

  $("#press").click(function() {
    $.ajax({
      url: 'count2',
      data: {
          value: $(this).val()
      },
      type: "GET",
      success: function(data) {
        var a = parseInt(data);
        $('#display2').css('display', 'none');
        $('#press_count').html('<p>'+a+'</p>');
      }
    });
  });

  $("#pitch").click(function() {
    $.ajax({
      url: 'count3',
      data: {
          value: $(this).val()
      },
      type: "GET",
      success: function(data) {
        var a = parseInt(data);
        $('#display3').css('display', 'none');
        $('#pitch_count').html('<p>'+a+'</p>');
      }
    });
  });


  var txt = ['startup story.', 'landing page.', 'press kit.', 'pitch contest.'],
    n = txt.length,
    $swap = $('#swap'),
    $span,
    c = -1;

  // CREATE SPANS INSIDE SPAN
  for(var i=0; i<txt.length; i++) $swap.append($('<span />',{text:txt[i]}));
  // HIDE AND COLLECT THEM
  $span = $("span", $swap).hide(); 

  (function loop(){
    c = ++c % n;
    $swap.animate({width: $span.eq( c ).width() });
    $span.stop().fadeOut().eq(c).fadeIn().delay(1000).show(0, loop);
  }()); 

});
