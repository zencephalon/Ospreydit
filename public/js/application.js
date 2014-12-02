$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // Reply link
  $('#content').on('click', '.reply_link', function(event) {
    event.preventDefault();
    var $target = $(event.target);

    console.log($target.parent());
    $target.parent().children('.comment_form').show(); 
  })

  // Edit link
  $('#content').on('click', '.edit_link', function(event) {
    event.preventDefault();
    var $target = $(event.target);
 
    $target.closest('.comment').children('.edit_form').show();
  })

  $('#content').on('submit', '.update_form form', function(event) {
    event.preventDefault();
    var $target = $(event.target);
    var $comment = $target.closest('.comment');
    $.ajax({
      url: $target.attr('action'),
      method: 'PUT',
      data: $target.serialize(),
      dataType: 'JSON'
    }).done(function(response) {
      $comment.find('.comment_content').first().text(response.text);
      $comment.children('.edit_form').hide();
    })
  })

  $('#content').on('submit', '.comment_form form', function(event) {
    event.preventDefault();
    var $target = $(event.target); 

    $target.parent().hide();

    $.ajax({
      url: $target.attr('action'),
      type: $target.attr('method'),
      data: $target.serialize()
    }).done(function (response) {
      response = "<li>" + response + "</li>";
      $target.parent().parent().children('ol.children').append(response);
    }) 
  })

  // $('.comment_form form').submit(function(event) {

  // });

  $('.delete_btn').click(function(event) {
    event.preventDefault();
    var $target = $(event.target);
    $target.val("Deleting...");
    $target.attr("disabled", "true");
    action = $target.parent().attr('action');

    $.ajax({
      url: action,
      type: "DELETE"
    }).done(function() {
      $target.parents('.comment').remove();
    });
  });
});
