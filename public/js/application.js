$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  $('#comment_container').on('click', '.reply_link', function(event) {
    event.preventDefault();
    $(event.target).parent().children('.reply_box').show();
    $(event.target).remove();
  });

  $('#comment_container').on('submit', '.comment_form', function(event) {
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
