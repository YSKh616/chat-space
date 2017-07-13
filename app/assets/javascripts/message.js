$(function() {
  function buildHTML(message){
    var html = `<div class="chat-display__main__message">
                  <p class="chat-display__main__message--sender">${message.user_name}</p>
                  <span>${message.created_at}</span>
                  <p class="chat-display__main__message--chat">${message.body}</p>`;
    if(message.image.url) {
      html += `<p class="chat-display__main__message--chat-image">
                 <image src="${message.image.url}">
              </p></div>`;
    } else {
      html += `<p class="chat-display__main__message--chat-image"></p></div>`;
    }
    return html;
  }
  $('#send_message').on('submit', function(e) {
    e.preventDefault();
    var url = $(this).prop("action");
    var form = $('#send_message').get()[0];
    var formData = new FormData(form);
    $.ajax({
      type: 'POST',
      url: url,
      data: formData,
      processData: false,
      contentType: false,
      dataType: 'json',
    })
    .done(function(data){
      var html = buildHTML(data);
      var position = $('.chat-display__main').find($(".chat-display__main__message:last-child")).get(0).offsetTop
      $('.chat-display__main').append(html).not(":animated").animate({scrollTop:position});
      $('.text').val('');
      $('.image-upload').val('');
      $(".message__button").prop("disabled",false);
    })
    .fail(function(){
      window.alert('テキストまたは画像ファイルを送信してください。');
    })
  });
  var interval = setInterval(function() {
    //URLが変わったときにsetIntervalの動作を停止
    if (window.location.href.match(/\/groups\/\d+\/messages/)) {
      $.ajax({
        url: location.href,
        dataType: 'json'
      })
      .done(function(json) {
        var html = '';      //初期化(空にする)
        var id = $('.chat-display__main').find(".chat-display__main__message:last-child").attr('data-message-id');
        json.messages.forEach(function(message) {
          if (message.id > id ) {   //messageのidが新しい場合に保存していく
            html += buildHTML(message);
          }
        });
        $('.chat-display__main').append(html);

        var position = $('.chat-display__main').find($(".chat-display__main__message:last-child")).get(0).offsetTop
        $('.chat-display__main').append(html).not(":animated").animate({scrollTop:position});
      })
      .fail(function(data) {
        alert('自動更新に失敗しました');
      });
    } else {
      clearInterval(interval);
    }} , 5000 );
});
