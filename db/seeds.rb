# db/seeds.rb
puts "🌱 Seeding database..."

# --- Users ---
users = [
  { email_address: "admin@test.com", password: "password" },
  { email_address: "test@test.com", password: "password" },
  { email_address: "user2@example.com", password: "password" }
]

users.each do |attrs|
  user = User.find_or_create_by!(email_address: attrs[:email_address]) do |u|
    u.password = attrs[:password]
  end
  # Ensure password is updated in case the user already existed
  user.update!(password: attrs[:password])
end

user1 = User.find_by!(email_address: "admin@test.com")
user2 = User.find_by!(email_address: "test@test.com")
user3 = User.find_by!(email_address: "user2@example.com")

puts "✅ Users created: #{User.count}"

# --- Clients ---
clients_data = [
  { user: user2, first_name: "Jane", last_name: "Doe", email: "jane@example.com", phone: "+15551234567" },
  { user: user2, first_name: "John", last_name: "Smith", email: "john@example.com", phone: "+15559876543" },
  { user: user1, first_name: "Alex", last_name: "Johnson", email: "alex@example.com", phone: "+15557654321" }
]

clients_data.each do |attrs|
  Client.find_or_create_by!(user: attrs[:user], email: attrs[:email]) do |c|
    c.first_name = attrs[:first_name]
    c.last_name  = attrs[:last_name]
    c.phone      = attrs[:phone]
  end
end

puts "✅ Clients created: #{Client.count}"

# --- Appointments ---
appointments_data = [
  { client: Client.find_by!(email: "jane@example.com"), scheduled_at: 1.day.from_now, duration_minutes: 60, location: :office, status: :scheduled },
  { client: Client.find_by!(email: "jane@example.com"), scheduled_at: 1.day.from_now,     duration_minutes: 30, location: :virtual, status: :completed },
  { client: Client.find_by!(email: "john@example.com"), scheduled_at: 3.days.from_now, duration_minutes: 45, location: :phone, status: :canceled }
]

appointments_data.each do |attrs|
  Appointment.find_or_create_by!(
    client: attrs[:client],
    scheduled_at: attrs[:scheduled_at].change(sec: 0)
  ) do |a|
    a.duration_minutes = attrs[:duration_minutes]
    a.location = attrs[:location]
    a.status = attrs[:status]
  end
end

puts "✅ Appointments created: #{Appointment.count}"

# --- Notes ---
notes_data = [
  { appointment: Appointment.first, content: "Discuss follow-up actions and next steps." },
  { appointment: Appointment.second, content: "Reviewed previous session progress." },
  { appointment: Appointment.third, content: "Client canceled due to scheduling conflict." }
]

notes_data.each do |attrs|
  Note.find_or_create_by!(appointment: attrs[:appointment], content: attrs[:content])
end

puts "✅ Notes created: #{Note.count}"
puts "🎉 Seeding complete!"
