import { Router } from "express";
import passport from "passport";
import jwt from "jsonwebtoken";
import { register, login, logout, authStatus, setup2FA, verify2Fa, 
        reset2FA, forgotPassword, resetPassword } from "../controllers/authController.js";

const router = Router();

// Registration
router.post("/register", register);

//login
router.get("/login", passport.authenticate("local", {failureRedirect: login}), login);

router.post("/login", (req, res, next) => {
  passport.authenticate("local", (err, user, info) => {
    if (err) return next(err);
    if (!user) return res.status(401).json({ error: info?.message || "Invalid credentials" });

    req.logIn(user, (err) => {
      if (err) return next(err);

      const token = jwt.sign(
        { username: user.username, id: user._id },
        process.env.JWT_SECRET,
        { expiresIn: "1h" }
      );

      return res.status(200).json({
        message: "User logged in successfully",
        username: user.username,
        isMfaActive: user.isMfaActive,
        token,
      });
    });
  })(req, res, next);
});

//Auth status
router.get("/status", authStatus);

//logout
router.post("/logout", logout);

//2FA Setup
router.post("/2fa/setup", (req, res, next) => {
  if(req.isAuthenticated()) return next();
  res.status(401).json({message: "Unauthorized User"});
}, setup2FA);

//verify route
router.post("/2fa/verify", (req, res, next) => {
  if(req.isAuthenticated()) return next();
  res.status(401).json({message: "Unauthorized User"});
}, verify2Fa);

//reset route
router.post("/2fa/reset", (req, res, next) => {
  if(req.isAuthenticated()) return next();
  res.status(401).json({message: "Unauthorized User"});
}, reset2FA);


// Send OTP to reset password
router.post("/forgot-password", forgotPassword);

// Reset password using OTP
router.post("/reset-password", resetPassword);

export default router;