$(function() {
  function buildHTML(message){
    var html = `<p class="chat-display__main--sender">
                  ${message.user_name}
                <span>
                  ${message.created_at}
                <p class="chat-display__main--chat">
                  ${message.body}
                </p>`
                <% if(message.image) %>
                  `<p class="chat-display__main--chat">
                      <image src="${message.image}">
                  </p>`
                <% end %>
    return html;
  }
  $('#send_message').on('submit', function(e) {
    e.preventDefault();
    var url = window.location.href;
    var form = $('#send_message').get()[0];
    var formData = new FormData(form);
    console.log(formData);
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
      $('.chat-display__main').append(html)
      $('.text').val('')
    })
    .fail(function(){
      alert('error');
    })
  });
});
