import bcrypt from "bcryptjs";
import User from "../models/user.js";
import speakeasy from "speakeasy";
import jwt from "jsonwebtoken";
import { sendVerificationEmail } from "../utils/emailService.js";
import { sendVerificationSMS } from "../utils/smsService.js";

// --------------------
// User Registration (stateless, concurrent-safe)
// --------------------
export const register = async (req, res) => {
  try {
    const { whoAmI, firstName, lastName, username, email, mobileNo, password, pinCode, date } = req.body;
    if (!username || !password || !email || !mobileNo)
      return res.status(400).json({ error: "Username, Password, Email, and Mobile Number are required" });

    // Check for duplicates (atomic check)
    const existingUser = await User.findOne({ $or: [{ username }, { email }, { mobileNo }] });
    if (existingUser)
      return res.status(409).json({ error: "User with given credentials already exists" });

    const hashedPassword = await bcrypt.hash(password, 10);

    // Save new user independently (no shared state)
    await User.create({
      whoAmI,
      username,
      firstName,
      lastName,
      email,
      mobileNo,
      pinCode,
      date,
      password: hashedPassword,
      isMfaActive: false,
    });

    return res.status(201).json({ message: "User Registration Successful" });
  } catch (error) {
    console.error("❌ Registration Error:", error);
    return res.status(500).json({ error: "User Registration Failed", message: error.message });
  }
};

// --------------------
// Login (stateless JWT-based)
// --------------------
// --------------------
// Login (with wrong password handling + proper JSON responses)
// --------------------
export const login = async (req, res) => {
  try {
    const { username, password } = req.body;

    if (!username || !password) {
      return res.status(400).json({ error: "Username and password are required" });
    }

    // Find user by username or email or mobile
    const user = await User.findOne({
      $or: [{ username }, { email: username }, { mobileNo: username }],
    });

    if (!user) {
      return res.status(401).json({ error: "Invalid username or password" });
    }

    // Compare password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ error: "Invalid username or password" });
    }

    // Generate token if valid
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
  } catch (error) {
    console.error("❌ Login Error:", error);
    return res.status(500).json({
      error: "Login failed",
      message: error.message,
    });
  }
};


// --------------------
// Auth Status (no dependency)
// --------------------
export const authStatus = async (req, res) => {
  if (req.user)
    return res.status(200).json({
      message: "User Authenticated",
      username: req.user.username,
      isMfaActive: req.user.isMfaActive,
    });
  else return res.status(401).json({ message: "Unauthorized User" });
};

// --------------------
// Logout (stateless JWT)
// --------------------
export const logout = async (req, res) => {
  // JWT-based logout is client-side (just discard token)
  return res.status(200).json({ message: "Logout successful (invalidate token on client)" });
};

// --------------------
// Setup 2FA (only once per user)
// --------------------
export const setup2FA = async (req, res) => {
  try {
    const { type } = req.body;
    if (!type) return res.status(400).json({ error: "2FA type is required (sms/email)" });

    const user = req.user;
    if (!user) return res.status(401).json({ error: "Unauthorized user" });

    // Don't generate a new secret if 2FA is already active
    let secretBase32 = user.twoFactorSecret;
    if (!secretBase32) {
      const secret = speakeasy.generateSecret({ length: 20 });
      secretBase32 = secret.base32;
      user.twoFactorSecret = secretBase32;
      user.isMfaActive = true;
      await user.save();
    }

    // Generate current OTP (based on stored secret)
    const otp = speakeasy.totp({
      secret: secretBase32,
      encoding: "base32",
      window: 20,
    });

    // Send OTP
    if (type === "email") {
      await sendVerificationEmail(user.email, user.username, otp);
    } else if (type === "sms") {
      await sendVerificationSMS(user.mobileNo, otp);
    } else {
      return res.status(400).json({ error: "Invalid 2FA type (use sms or email)" });
    }

    return res.status(200).json({ message: `2FA ${type} OTP sent successfully` });
  } catch (error) {
    console.error("❌ Setup 2FA Error:", error);
    return res.status(500).json({ error: "Error Setting up 2FA", message: error.message });
  }
};

// --------------------
// Verify 2FA (corrected token check)
// --------------------
export const verify2Fa = async (req, res) => {
  try {
    const { token } = req.body;
    const user = req.user;
    if (!user) return res.status(401).json({ error: "Unauthorized user" });
    if (!user.twoFactorSecret) return res.status(400).json({ error: "2FA not set up for this user" });

    const verified = speakeasy.totp.verify({
      secret: user.twoFactorSecret,
      encoding: "base32",
      token: token.trim(),
      window: 2, // allow ±60 seconds drift
    });

    if (!verified) {
      return res.status(400).json({ message: "Invalid or expired 2FA Token" });
    }

    const jwtToken = jwt.sign({ username: user.username }, process.env.JWT_SECRET, { expiresIn: "1h" });

    return res.status(200).json({ message: "2FA Verified Successfully", token: jwtToken });
  } catch (error) {
    console.error("❌ Verify 2FA Error:", error);
    return res.status(500).json({ error: "Error verifying 2FA Token", message: error.message });
  }
};

// --------------------
// Reset 2FA (independent per user)
// --------------------
export const reset2FA = async (req, res) => {
  try {
    const user = req.user;
    if (!user) return res.status(401).json({ error: "Unauthorized user" });

    user.twoFactorSecret = "";
    user.isMfaActive = false;
    await user.save();

    return res.status(200).json({ message: "2FA reset successfully" });
  } catch (error) {
    console.error("❌ Reset 2FA Error:", error);
    return res.status(500).json({ error: "Error Resetting 2FA", message: error.message });
  }
};

// --------------------
// Forgot Password (independent, stateless OTP)
// --------------------
export const forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;
    if (!email) return res.status(400).json({ error: "Email is required" });

    const user = await User.findOne({ email });
    if (!user) return res.status(404).json({ error: "User not found" });

    const secret = speakeasy.generateSecret({ length: 20 });
    user.resetSecret = secret.base32;
    await user.save();

    const otp = speakeasy.totp({
      secret: secret.base32,
      encoding: "base32",
      step: 300, // 5 minutes
    });

    await sendVerificationEmail(email, user.username, otp);

    return res.status(200).json({ message: "Password reset OTP sent to email" });
  } catch (error) {
    console.error("❌ Forgot Password Error:", error);
    return res.status(500).json({ error: "Unable to send password reset OTP", message: error.message });
  }
};

// --------------------
// Reset Password (stateless OTP validation)
// --------------------
export const resetPassword = async (req, res) => {
  try {
    const { email, otp, newPassword } = req.body;
    if (!email || !otp || !newPassword)
      return res.status(400).json({ error: "Email, OTP, and new password are required" });

    const user = await User.findOne({ email });
    if (!user || !user.resetSecret)
      return res.status(404).json({ error: "User or reset secret not found" });

    const verified = speakeasy.totp.verify({
      secret: user.resetSecret,
      encoding: "base32",
      token: otp,
      step: 300,
      window: 1,
    });

    if (!verified) return res.status(400).json({ error: "Invalid or expired OTP" });

    user.password = await bcrypt.hash(newPassword, 10);
    user.resetSecret = undefined;
    await user.save();

    return res.status(200).json({ message: "Password reset successfully" });
  } catch (error) {
    console.error("❌ Reset Password Error:", error);
    return res.status(500).json({ error: "Unable to reset password", message: error.message });
  }
};
