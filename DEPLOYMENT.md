

---

````markdown
# Personal Finance Tracker - Deployment Guide

This document explains how to deploy the **Personal Finance Tracker** project with **Backend on Render** and **Frontend on Vercel**, including environment setup, CORS, SPA routing, and notes.

---

## Project Overview

**Frontend URL:** [https://personal-finance-tracker.vercel.app](https://personal-finance-tracker.vercel.app)  
**Backend URL:** [https://personal-finance-tracker-hpnp.onrender.com](https://personal-finance-tracker-hpnp.onrender.com)

**Description:**  
A full-stack web application that helps users track income, expenses, and visualize financial data effortlessly.

---

## 1. Backend Deployment (Render)

### 1.1 Prerequisites
- Node.js backend with Express.js
- MySQL database (e.g., [FreeSQLDatabase](https://www.freesqldatabase.com/))
- Redis Cloud (if using sessions)
- JWT for authentication

### 1.2 Deployment Steps
1. Push backend code to GitHub.
2. Create a new Web Service on [Render](https://render.com/) and connect the repository.
3. Set environment variables in Render (from your `.env` file):
    ```env
    PORT=5000
    MYSQL_HOST=<your-mysql-host>
    MYSQL_USER=<your-mysql-user>
    MYSQL_PASSWORD=<your-mysql-password>
    MYSQL_DATABASE=<your-database-name>
    JWT_SECRET=<your-jwt-secret>
    REDIS_URL=<your-redis-cloud-url>
    ```
4. Update **CORS in `app.js`** to allow frontend domain:
    ```js
    import cors from 'cors';

    app.use(cors({
      origin: [
        'http://localhost:5173', // local development
        'https://personal-finance-tracker.vercel.app' // production frontend
      ],
      credentials: true
    }));
    ```
5. Deploy backend. Render provides the public URL:  
   `https://personal-finance-tracker-hpnp.onrender.com`

---

## 2. Frontend Deployment (Vercel)

### 2.1 Prerequisites
- React + Vite frontend
- Axios for API calls
- Material UI / Chart.js / Recharts

### 2.2 Environment Variables
Create `.env.production` in frontend root:

```env
VITE_API_BASE_URL=https://personal-finance-tracker-hpnp.onrender.com/api
````

### 2.3 Axios Configuration (`api.js`)

```js
import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: { 'Content-Type': 'application/json' },
  withCredentials: true // important for JWT/cookies
});

export default api;
```

### 2.4 SPA Routing Fix

Create `vercel.json` in frontend root:

```json
{
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
```

### 2.5 Build & Deploy

1. Commit all changes:

```bash
git add .
git commit -m "Frontend deployment config: API URL, SPA routing, Axios credentials"
git push origin master
```

2. Connect frontend repo to [Vercel](https://vercel.com/).
3. Set **Build & Output settings**:

   * Install Command: `npm install`
   * Build Command: `npm run build`
   * Output Directory: `dist`
4. Deploy. Vercel provides the public frontend URL:
   `https://personal-finance-tracker.vercel.app`

---

## 3. Testing

1. Open frontend URL in browser.
2. Test login / registration → JWT authentication should work.
3. Test SPA routes → no 404 errors.
4. Test API calls → should hit Render backend.

---

## 4. Notes / Tips

* Always update `VITE_API_BASE_URL` if backend URL changes.
* `withCredentials: true` is essential for cookies/JWT.
* Backend CORS must include frontend domain.
* SPA fallback via `vercel.json` prevents React Router 404 errors.
* Node version for frontend build: `22.x` (set in `package.json` if needed):

```json
"engines": {
  "node": "22.x"
}
```

* For build permission errors with Vite:

```bash
rm -rf node_modules package-lock.json
npm install
```

---

This completes the deployment process for **Personal Finance Tracker** with **Backend on Render** and **Frontend on Vercel**.




