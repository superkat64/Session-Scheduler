# db/seeds.rb
puts "🌱 Seeding database..."

User.find_or_create_by!(email_address: "admin@example.com") do |user|
  user.password = "password"
end

clients = [
  { name: "Jane Doe" },
  { name: "John Smith" }
]

clients.each do |attrs|
  Client.find_or_create_by!(name: attrs[:name]) do |client|
    client.user = User.first
  end
end

Appointment.find_or_create_by!(
  client: Client.first,
  scheduled_at: 1.day.from_now,
  location: "",
  status: "",
  duration_minutes: 60
)

puts "✅ Done seeding!"