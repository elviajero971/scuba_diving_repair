
# 🦑 Scuba Diving Regulator Maintenance App

## 🚀 Introduction

This repository contains a **Ruby on Rails** application designed for scuba divers to book **regulator maintenance services**. Divers can create an account, select their regulator model, choose between **regular** and **premium service** options, and track the maintenance status through a user-friendly dashboard.

The app is built using **Tailwind CSS** for responsive, modern styling and integrates with **PostgreSQL** for robust database management. It also includes an **admin dashboard** for service providers to manage bookings and update service statuses.

## 🎯 Features

- **User authentication**: Sign up, log in, password reset, and profile management.
- **Regulator maintenance booking**: Choose from regular or premium services and select the regulator model.
- **Service status tracking**: Track the status of booked services (e.g., Paid, In Progress, Serviced).
- **Admin dashboard**: Manage bookings, update service statuses, and oversee orders.
- **Responsive design**: Mobile-friendly interface built with **Tailwind CSS**.

## 🛠️ Getting Started

### Prerequisites

Ensure you have the following installed on your machine:

- **Ruby >= 3.0**
- **Rails >= 7.2**
- **PostgreSQL**
- **Node.js** and **Yarn**

### Installation

Clone this repository and install the dependencies:

```bash
# Clone the repository
git clone https://github.com/elviajero971/scuba-maintenance-app.git

# Navigate to the project directory
cd scuba-maintenance-app

# Install Ruby and Node.js dependencies
bundle install
yarn install

# Setup the database
rails db:create
rails db:migrate
```

### Running the Application

Start the Rails server:

```bash
rails server
```

You can now visit the application in your browser at `http://localhost:3000`.

### Building for Production

To deploy the app in production, make sure to set up the following environment variables:

- **SECRET_KEY_BASE**: A unique secret key for Rails.
- **DATABASE_URL**: PostgreSQL database URL.
- **Other service environment variables**.

You can precompile assets and run the server in production mode:

```bash
RAILS_ENV=production rails assets:precompile
RAILS_ENV=production rails server
```

## ⚙️ Booking Features

1. **Service Options**: Users can select from **Regular** and **Premium** maintenance services, depending on their desired service speed.
2. **Regulator Models**: A dropdown allows users to specify the **regulator brand** and **model** for accurate service.
3. **Booking Status**: Users can track the status of their bookings, including states like **Paid**, **In Progress**, **Serviced**, and **Ready for Pickup**.

## 👩‍💻 Admin Features

1. **Dashboard**: Admins can manage incoming bookings and track regulator service status.
2. **Service Updates**: Admins can update the status of a booking and notify users when their equipment is ready for pickup.
3. **User Management**: Admins can view and manage customer profiles.

## 🧩 Technologies Used

- **Ruby on Rails**: Backend framework for building the application.
- **Tailwind CSS**: Utility-first CSS framework for designing responsive UI.
- **PostgreSQL**: Database management for user, booking, and service records.
- **Devise**: For user authentication and management.
- **Active Admin**: Used to manage bookings and customers as an admin.

## 📈 Project Roadmap

```diff
+ MVP : Implement user registration and authentication
+ MVP : Create booking system with regulator selection
+ MVP : Admin dashboard for managing users, payments, services, gears, products
+ FEATURE : Integrate payment gateway for online payments
- FEATURE : Add notification emails for booking updates
- FEATURE : Implement delay logic for service status updates
- FEATURE : Internationalization for multi-language support fr / en / es / ca
- FEATURE : Implement graphing and analytics for service data with chartkick and groupdate gem
```

## ⚙️ API Setup

You may need to add API integrations in the future to support payment processing or additional functionality.

### Environment Variables:

Make sure to include the following keys in your `.env` file for production:

```bash
# .env
SECRET_KEY_BASE=your-rails-secret-key
DATABASE_URL=your-production-database-url
```

## 🌐 Live Demo

You can view the live version of this application at: [https://scuba-maintenance-app.com](https://your-demo-link.com)

## 📬 Contact

- **Email**: [lucas.illiano@hotmail.com](mailto:lucas.illiano@hotmail.com)
- **LinkedIn**: [https://www.linkedin.com/in/lucas-illiano/](https://www.linkedin.com/in/lucas-illiano/)
- **GitHub**: [https://github.com/elviajero971/](https://github.com/elviajero971/)

Feel free to reach out if you have any questions, suggestions, or if you'd like to collaborate on this project!

---

### License

This project is licensed under the MIT License.
