require './config/environment'

Parent.find_or_create_by(email: "you@yahoo.com", password_digest: "youperson", first_name: "You", last_name: "Yourself")
Parent.find_or_create_by(email: "him@yahoo.com", password_digest: "himperson", first_name: "Him", last_name: "Himself")
Parent.find_or_create_by(email: "her@yahoo.com", password_digest: "herperson", first_name: "Her", last_name: "Herself")

Child.find_or_create_by(name: "Abe", password_digest: "abechild", parent_id: 1)
Child.find_or_create_by(name: "Barb", password_digest: "barbchild", parent_id: 1)
Child.find_or_create_by(name: "Carrie", password_digest: "carriechild", parent_id: 1)
Child.find_or_create_by(name: "Damien", password_digest: "damienchild", parent_id: 2)
Child.find_or_create_by(name: "Evil", password_digest: "evilchild", parent_id: 2)
Child.find_or_create_by(name: "Fido", password_digest: "fidochild", parent_id: 2)
Child.find_or_create_by(name: "Georgie", password_digest: "georgiechild", parent_id: 3)
Child.find_or_create_by(name: "Henri", password_digest: "henrichild", parent_id: 3)
Child.find_or_create_by(name: "Iggy", password_digest: "iggychild", parent_id: 3)

Chore.find_or_create_by(name: "Dishes", parent_id: 1, value: 2.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Vacuum", parent_id: 1, value: 2.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Mow", parent_id: 1, value: 4.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Dishes", parent_id: 2, value: 2.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Vacuum", parent_id: 2, value: 2.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Mow", parent_id: 2, value: 4.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Dishes", parent_id: 3, value: 2.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Vacuum", parent_id: 3, value: 2.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Mow", parent_id: 3, value: 4.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Laundry", parent_id: 1, value: 4.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Laundry", parent_id: 2, value: 4.00, tagged_complete: 0)
Chore.find_or_create_by(name: "Laundry", parent_id: 3, value: 2.00, tagged_complete: 0)