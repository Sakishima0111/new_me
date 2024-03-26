//ローディング画面の表示
$(window).on('load',function(){
  $("#loading").delay(1500).fadeOut('slow');//ローディング画面を1.5秒（1500ms）待機してからフェードアウト
  $("#loading_box").delay(1200).fadeOut('slow');//ローディングテキストを1.2秒（1200ms）待機してからフェードアウト
});

window.addEventListener('scroll',function() {
  const height = window.innerHeight;                    //画面の高さを取得
  const scroll = this.pageYOffset;                      //スクロール量
  const marker = document.querySelectorAll('.marker');  //マーカーを引く要素を取得
  const value = scroll - height + 300                   //後ろの数字を弄ることで、イベント位置をずらす

  // markerクラスを持っている要素全てに処理を行う
  marker.forEach(function(element){
      //要素が画面内の指定の位置に来たら「on」クラスをつける
      if (scroll > element.getBoundingClientRect().top + value) {
          element.classList.add('on')
      }
  });
})

// スクロールトップ
$(function () {
  // スクロールしたら「トップに戻る」ボタンが表示される
  const toTopButton = $(".js-to-top");
  const scrollHeight = 100;
  toTopButton.hide();
  $(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
      toTopButton.fadeIn();
    } else {
      toTopButton.fadeOut();
    }
  });

  // 「トップに戻る」ボタンをクリックしたらスクロールで戻る
  toTopButton.click(function () {
    $("body,html").animate({ scrollTop: 0 }, 800);
    return false;
  });
});