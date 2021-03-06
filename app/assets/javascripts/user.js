$(function() {
  function addUser(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
                </div>`;
    return html;
  }

  function addMembers(user) {
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
                  <input name='group[user_ids][]' type='hidden' value='${user.attr("data-user-id")}'>
                  <p class='chat-group-user__name'>${user.attr("data-user-name")}</p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
                </div>`;
    return html;
  }

  $("#user-search-field").on("keyup", function() {
    var input = $("#user-search-field").val();
    $.ajax({
      type: 'GET',
      url: '/users',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(data){
      $('#user-search-result').empty();
      if(data.length !== 0){
        data.forEach(function(user){
          var html = addUser(user);
          $('#user-search-result').append(html);
        });
      }
    })
    .fail(function(){
      window.alert('ユーザ検索に失敗しました。');
    })
  });

  $(document).on('click', '.user-search-add', function() {
    var html = addMembers($(this))
    $("#member_list").append(html)
    $(this).parent().remove();
  })

  $(document).on('click', '.user-search-remove', function() {
    $(this).parent().remove();
  })
});
