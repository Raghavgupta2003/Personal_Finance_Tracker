# 💸 Personal Finance Tracker

**Live Link:** [Coming Soon]()

A full-stack web application that helps users track income, expenses, and visualize financial data effortlessly. Built using **React**, **Node.js**, **MySQL**, and **Redis**.

---

## 🚀 Features

* 🔐 User Authentication (Login/Register)
* 📥 Add, Edit, Delete Transactions
* 📊 View All Transactions in Tabular Format
* 🔎 Filter by Type, Category, and Date Range
* 📈 Visual Analytics: Income, Expense, Net Balance
* ⚡ Redis Caching for Performance
* ✅ Protected Routes with JWT
* 🌐 Fully Deployed on Vercel

---

## 🧱 Tech Stack

### Frontend

* React.js (Vite)
* Axios
* React Router
* Plain CSS

### Backend

* Node.js
* Express.js
* MySQL
* JWT Authentication
* Redis (Cloud)

---

## 🛠️ Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/Raghavgupta2003/Personal_Finance_Tracker.git
cd Personal_Finance_Tracker
```

### 2. Backend Setup

```bash
cd backend
npm install
```

Create a `.env` file in the `backend` folder with the following variables:

```env
DB_HOST=your_db_host
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_NAME=your_db_name
DB_PORT=your_db_port
JWT_SECRET=your_jwt_secret
REDIS_HOST=your_redis_host
REDIS_PORT=your_redis_port
REDIS_PASSWORD=your_redis_password
```

> **Note:** You can use free services to set up your backend:
>
> * MySQL: [https://www.freesqldatabase.com/](https://www.freesqldatabase.com/)
> * Redis Cloud: [https://cloud.redis.io/](https://cloud.redis.io/)

Start the backend server:

```bash
npm start
```

### 3. Frontend Setup

```bash
cd ../frontend
npm install
```

Create a `.env` file in the `frontend` folder:

```env
API_BASE_URL=http://localhost:5000/api
```

Start the frontend server:

```bash
npm run dev
```

---

## 🌐 Environment Variables

| Variable       | Description               |
| -------------- | ------------------------- |
| DB_HOST        | MySQL database host       |
| DB_USER        | MySQL database username   |
| DB_PASSWORD    | MySQL database password   |
| DB_NAME        | MySQL database name       |
| DB_PORT        | MySQL port (default 3306) |
| JWT_SECRET     | Secret key for JWT tokens |
| REDIS_HOST     | Redis cloud host          |
| REDIS_PORT     | Redis port                |
| REDIS_PASSWORD | Redis password            |
| API_BASE_URL   | Frontend API base URL     |

---

## 🧪 Features to Try

* Register a new user and login
* Add, edit, and delete income/expense transactions
* Filter transactions by type, category, or date
* Explore the analytics tab for visual summaries

---

## 📌 TODO

* Add password reset functionality
* Export transaction data to CSV
* Admin dashboard for user management

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first.

---

## 📄 License

This project is licensed under the MIT License.

---

## 💬 Connect with Me

* GitHub: [@Raghav-Gupta](https://github.com/Raghav-Gupta)
* LinkedIn: [Raghav Gupta](https://www.linkedin.com/in/raghav-gupta2003/)

