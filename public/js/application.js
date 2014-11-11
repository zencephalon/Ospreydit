$(document).ready(function() {

  $('#comment_container').on('click', '.edit_btn', function(event) {
    event.preventDefault();
    $target = $(event.target);
    $comment = $target.closest('.comment');
    $comment.children('.edit_box').show();
    $comment.children('.comment_content').hide();
  });

  $('#comment_container').on('submit', '.edit_box .comment_form', function(event) {
    event.preventDefault();
    $target = $(event.target);
    $comment_content = $target.closest('.comment').find('.comment_content').first();

    $.ajax({
      url: $target.attr("action"),
      type: $target.attr("method"),
      data: $target.serialize(),
      dataType: "JSON"
    }).done(function(response) {
      $comment_content.children('.comment_text').html(response.comment_text);
      $comment_content.show();
      $target.parent().hide();
    });
  });

  // pre-refactoring
  // $('.reply_link').click(function() { ... });
  $('#comment_container').on('click', '.reply_link', function(event) {
    event.preventDefault();
    $(event.target).parent().children('.reply_box').show();
    $(event.target).remove();
  });

  $('#comment_container').on('submit', '.reply_box .comment_form', function(event) {
    event.preventDefault();
    console.log(event.target);
    $form = $(event.target);
    $.ajax({
      type: $form.attr('method'),
      url: $form.attr('action'),
      data: $form.serialize()
    }).done(function(response) {
      $form.closest('.comment').children('.children').append("<li>" + response + "</li>")
      $form.parent().remove();
    });
  })

  $('#comment_container').on('click', '.vote_btn', function(event) {
    event.preventDefault();
    $target = $(event.target);
    $target.val("Voting...");
    $target.attr("disabled", "true");
    $form = $target.parent();

    $.ajax({
      type: $form.attr('method'),
      url: $form.attr('action'),
      dataType: "JSON"
    }).done(function (response) {
      $form.parent().children('.score_display').html(response.score);
      $target.val("Voted");
    });
  })

  $('#comment_container').on('click', '.delete_btn', function(event) {
    event.preventDefault();
    $target = $(event.target);
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
