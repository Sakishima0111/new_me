//ローディング画面の表示
$(window).on('load',function(){
  $("#loading").delay(1500).fadeOut('slow');//ローディング画面を1.5秒（1500ms）待機してからフェードアウト
  $("#loading_box").delay(1200).fadeOut('slow');//ローディングテキストを1.2秒（1200ms）待機してからフェードアウト
});

  $(document).ready(function() {
    $('#notifications-link').click(function() {
      // 通知を確認済みに更新するアクションを呼び出す
      $.ajax({
        url: '<%= update_checked_notifications_path %>',
        type: 'POST',
        success: function() {
          $('.n-circle').removeClass('orange');
          $('#notifications-link').html('<i class="far fa-bell fa-lg" style="font-size: 1.5em;"></i>');

          // 通知モーダルを表示する処理
          $.ajax({
            url: '<%= notifications_path(@user) %>',
            type: 'GET',
            success: function(response) {
              $('#notifications-modal .common-modal-content').html(response);
              $('#notifications-modal').addClass('fade-in').show();
            }
          });
        }
      });
    });

  // モーダル内のクリックイベントを停止
  $('#notifications-modal .modal-content').on('click', function(event) {
    event.stopPropagation(); // イベントの伝播を停止
  });

  // モーダル外（背景）をクリックしたときにモーダルを閉じる
  $('#notifications-modal').on('click', function() {
    $(this).addClass('fade-out');
    setTimeout(() => {
      $(this).hide().removeClass('fade-out');
    }, 300);
  });
});