#= require jquery
#= require jquery_ujs
#= require like
#= require subscribe
#= require comments
#= require pusher
#= require_tree.

$(document).ready ->

  Pusher.host = 'localhost'
  Pusher.ws_port = '3004'
  Pusher.wss_port = '3004'
  Pusher.sockjs_host = undefined
  Pusher.sockjs_http_port = undefined
  Pusher.sockjs_https_port = undefined
  Pusher.sockjs_path = undefined

  pusher = new Pusher('c46c644b78f84661ace01b35dffceabc')
  channel = pusher.subscribe('test_channel')
  channel.bind 'my_event', (data) ->

    t = new Date(data.message.created_at)
    t_year = t.getFullYear()
    t_day = t.getDate()
    t_min = t.getMinutes()
    t_hour = t.getUTCHours()
    t_month = (t.getMonth()+1)

    if t_month < 10
      t_month = '0' + t_month
    else
      t_month

    comment_date = t_year + '-' + t_month + '-' + t_day + ' ' + t_hour + ':' + t_min

    $('.comments_all').prepend('<div class="comment"><div class="comment_top"><div class="comment_name">' + data.user.name + '</div><div class="comment_date">' + comment_date + '</div><div class="comment_image"><a href="' + data.url + '">' + data.img_title + '</a></div></div><div class="comment_body"><pre>' + data.message.body + '</pre></div></div>')

