import express from "express";
import session from "express-session";
import passport from "passport";
import dotenv from "dotenv";
import cors from "cors";
import path from "path";
import { fileURLToPath } from "url"; 

import dbConnect from "./config/dbConfig.js"
import authRoutes from "./routes/authRoutes.js"
import "./config/passportConfig.js"

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.resolve(__dirname, "../.env") });

dotenv.config();
dbConnect();

const app = express();

const corsOption = {
  origin: ["htpp://localhost:4000"],
  Credentials: true
}

app.use(cors(corsOption));
app.use(express.json({limit: "100mb"}));
app.use(express.urlencoded({limit: "100mb", extended : true}));
app.use(session({
  secret: process.env.SESSION_SECRET || "secret",
  resave: false,
  saveUninitialized: false,
  cookie: {
    maxAge: 6000 * 60,
  }
}));

app.use(passport.initialize());
app.use(passport.session());
app.use("/api/auth", authRoutes);

const PORT = process.env.PORT || 4002;

app.listen(PORT, () => {
  console.log(`Ready to Go at ${PORT}`);
});

