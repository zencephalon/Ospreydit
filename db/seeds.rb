# Comment.create(text: "Hello, world.")
# Comment.create(text: "ILUVU.")

Sub.create(name: "Lovism")
Sub.create(name: "Buddhism")
Sub.create(name: "Daoism")

Comment.where(sub_id: nil).each do |comment|
  comment.update(sub: Sub.all.sample)
end