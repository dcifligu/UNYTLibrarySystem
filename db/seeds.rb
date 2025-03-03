# Clear existing data
User.destroy_all
Book.destroy_all
Journal.destroy_all
Reservation.destroy_all
Loan.destroy_all
Fine.destroy_all

# # Create Users
# users = [
#   { name: "John", surname: "Doe", email: "john@example.com", password: "password", contact_address: "contact", user_type: 1 },#admin
#   { name: "Jane", surname: "Smith", email: "jane@example.com", password: "password", contact_address: "contact", user_type: 0 },
#   { name: "Alice", surname: "Brown", email: "alice@example.com", password: "password", contact_address: "contact", user_type: 0 }
# ].map { |attrs| User.create!(attrs) }

# # Create Books
# books = [
#   { title: "The Great Gatsby", author: "F. Scott Fitzgerald", language: "English", publisher: "Scribner", publish_year: 1925, description: "A novel set in the Roaring Twenties." },
#   { title: "1984", author: "George Orwell", language: "English", publisher: "Secker & Warburg", publish_year: 1949, description: "Dystopian social science fiction novel." }
# ].map { |attrs| Book.create!(attrs) }

# # Create Journals
# journals = [
#   { title: "Nature", volume: 590, issue: 1, language: "English", publisher: "Springer", publish_year: 2021, description: "Scientific journal covering various disciplines." },
#   { title: "Science", volume: 375, issue: 2, language: "English", publisher: "AAAS", publish_year: 2022, description: "One of the world's top academic journals." }
# ].map { |attrs| Journal.create!(attrs) }

# # Create Reservations
# reservations = [
#   { user: users.first, reservable: books.first, status: 1, start_date: Time.now, end_date: 7.days.from_now },
#   { user: users.second, reservable: journals.first, status: 0, start_date: Time.now, end_date: 5.days.from_now }
# ].map { |attrs| Reservation.create!(attrs) }

# # Create Loans
# user = User.first
# book = Book.first

# loans = [
#   Loan.create!(user: users.first, loanable: books.first, start_date: Date.today, end_date: Date.today + 14.days, status: :active),
#   Loan.create!(user: users.second, loanable: journals.first, start_date: Date.today, end_date: Date.today + 10.days, status: :pending)
# ]

# # Create Fines
# fines = [
#   { user: users.first, loan: loans[0], amount: 10.50, status: 0, notes: "Overdue fine." },
#   { user: users.second, loan: loans[1], amount: 5.00, status: 1, notes: "Paid fine." }
# ].map { |attrs| Fine.create!(attrs) }

# puts "Seed data successfully created!"
