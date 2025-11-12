# Session Scheduler

A Ruby on Rails application for managing client appointments in medical and therapy practices. Built as a learning project to demonstrate Rails best practices and prepare for opportunities in healthcare software development.

## About This Project

Session Scheduler is designed to help medical and therapy providers manage their client appointments efficiently. While functional, this project primarily serves as a portfolio piece showcasing Rails development skills, clean code practices, and thoughtful feature implementation.

**Current Status:** Active development - core features implemented, additional functionality planned.

## Features

### Currently Implemented

- **Client Management** - Create and manage client records
- **Appointment Scheduling** - Book and manage therapy/medical sessions
- **Session Notes** - Document appointment details and client progress

### Planned Features

- Email notifications using ActionMailer and ActiveJob
- Billing and invoicing system
- Automated appointment reminders
- Calendar integrations
- Multi-provider support

## Tech Stack

- **Ruby on Rails** - Application framework
- **TailwindCSS** - Styles Library
- **PostgreSQL** - Database
- **Minitest** - Testing framework
- Additional gems and tools as needed

## Getting Started

### Prerequisites

- Ruby [3.3.1]
- Rails [8.0.4]
- PostgreSQL

### Installation

```bash
# Clone the repository
git clone https://github.com/superkat64/session-scheduler.git
cd session-scheduler

# Install dependencies
bundle install

# Set up the database
rails db:create
rails db:migrate

# Start the server
rails server
```

Visit `http://localhost:3000` to see the application.

### Running Tests

```bash
# Run the full test suite
rails test
# or
bundle exec rspec
```

## Project Goals

This project is being developed with the following learning objectives:

1. **Rails Fundamentals** - Demonstrate mastery of MVC architecture, RESTful routing, and Rails conventions
2. **Database Design** - Implement efficient database schemas and Active Record relationships
3. **Background Processing** - Practice asynchronous job handling with Active Job/Sidekiq
4. **Email Integration** - Build transactional email flows with ActionMailer
5. **Testing** - Maintain comprehensive test coverage
6. **Code Quality** - Follow Ruby style guides and Rails best practices

## Development Approach

- Following Test-Driven Development (TDD) principles where practical
- Emphasizing readable, maintainable code
- Using Git with meaningful commit messages
- Implementing features incrementally with proper documentation

## Inspiration

Built in preparation for interviewing with SimplePractice and similar healthcare software companies. The domain was chosen to align with the industry while providing rich opportunities to demonstrate various Rails capabilities.

## Contributing

This is a personal learning project, but feedback and suggestions are welcome! Feel free to open an issue if you notice areas for improvement.

## License

MIT

## Contact

Kate Piette | kat.piette@gmail.com | www.linkedin.com/in/katherinempiette

---

_Note: This is a portfolio/learning project and is not intended for production use in actual medical practices._
