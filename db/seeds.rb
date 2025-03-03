# Clear existing data
User.destroy_all
Book.destroy_all
Journal.destroy_all
Reservation.destroy_all
Loan.destroy_all
Fine.destroy_all

# Create Users
admin_user = User.create!(
  email: "admin@example.com",
  password: "password123",
  name: "Admin",
  surname: "User",
  contact_address: "123 Admin Street",
  user_type: 1 # Admin
)

regular_user = User.create!(
  email: "user@example.com",
  password: "password123",
  name: "Regular",
  surname: "User",
  contact_address: "456 User Avenue",
  user_type: 0 # Regular
)

# Create Books
book1 = Book.create!(
  title: "The Great Gatsby",
  author: "F. Scott Fitzgerald",
  language: "English",
  publisher: "Scribner",
  publish_year: 1925,
  description: "A classic novel about the American Dream."
)

book2 = Book.create!(
  title: "To Kill a Mockingbird",
  author: "Harper Lee",
  language: "English",
  publisher: "J.B. Lippincott & Co.",
  publish_year: 1960,
  description: "A story of racial injustice and moral growth."
)

# Create Journals
journal1 = Journal.create!(
  title: "Nature",
  volume: 592,
  issue: 7856,
  language: "English",
  publisher: "Springer Nature",
  publish_year: 2021,
  description: "A leading scientific journal."
)

journal2 = Journal.create!(
  title: "Science",
  volume: 372,
  issue: 6543,
  language: "English",
  publisher: "American Association for the Advancement of Science",
  publish_year: 2021,
  description: "A premier scientific research journal."
)

# Create Reservations
reservation1 = Reservation.create!(
  user: regular_user,
  reservable: book1,
  status: 0, # Pending
  start_date: Time.current,
  end_date: Time.current + 2.hours
)

reservation2 = Reservation.create!(
  user: regular_user,
  reservable: journal1,
  status: 1, # Approved
  start_date: Time.current,
  end_date: Time.current + 2.hours
)

# Create Loans
loan1 = Loan.create!(
  user: regular_user,
  loanable: book2,
  start_date: Date.today - 10.days,
  end_date: Date.today - 3.days,
  status: 2, # Overdue
  notes: "Loan overdue by 3 days."
)

loan2 = Loan.create!(
  user: regular_user,
  loanable: journal2,
  start_date: Date.today - 5.days,
  end_date: Date.today + 9.days,
  status: 0, # Active
  notes: "Loan active."
)

# Create Fines
Fine.create!(
  loan: loan1,
  user: regular_user,
  amount: 150.00,
  status: 0, # Pending
  notes: "Fine for overdue loan."
)

Fine.create!(
  loan: loan2,
  user: regular_user,
  amount: 0.00,
  status: 1, # Paid
  notes: "No fine for active loan."
)

puts "Seeding completed successfully!"