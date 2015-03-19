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


(function(f,b){if(!b.__SV){var a,e,i,g;window.mixpanel=b;b._i=[];b.init=function(a,e,d){function f(b,h){var a=h.split(".");2==a.length&&(b=b[a[0]],h=a[1]);b[h]=function(){b.push([h].concat(Array.prototype.slice.call(arguments,0)))}}var c=b;"undefined"!==typeof d?c=b[d]=[]:d="mixpanel";c.people=c.people||[];c.toString=function(b){var a="mixpanel";"mixpanel"!==d&&(a+="."+d);b||(a+=" (stub)");return a};c.people.toString=function(){return c.toString(1)+".people (stub)"};i="disable track track_pageview track_links track_forms register register_once alias unregister identify name_tag set_config people.set people.set_once people.increment people.append people.union people.track_charge people.clear_charges people.delete_user".split(" ");
for(g=0;g<i.length;g++)f(c,i[g]);b._i.push([a,e,d])};b.__SV=1.2;a=f.createElement("script");a.type="text/javascript";a.async=!0;a.src="undefined"!==typeof MIXPANEL_CUSTOM_LIB_URL?MIXPANEL_CUSTOM_LIB_URL:"//cdn.mxpnl.com/libs/mixpanel-2-latest.min.js";e=f.getElementsByTagName("script")[0];e.parentNode.insertBefore(a,e)}})(document,window.mixpanel||[]);
mixpanel.init("371e76e97593eeb6a8894975dec93421");


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

  $("#scroll-button").click(function(e) {
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


  var txt = ['startup story', 'brand DNA', 'landing page', 'press kit', 'pitch'],
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


