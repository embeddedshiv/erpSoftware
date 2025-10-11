import nodemailer from "nodemailer";
import fs from "fs";
import path from "path";
import dotenv from "dotenv";
import transporter from "../config/emailConfig.js";

dotenv.config();

export const sendVerificationEmail = async (to, username, otp) => {
  try {
    const templatePath = path.join(process.cwd(), "src", "utils", "templates", "emailTemplate.html");
    let htmlContent = fs.readFileSync(templatePath, "utf-8");
    htmlContent = htmlContent
      .replace("{{USERNAME}}", username)
      .replace("{{OTP}}", otp);
    const mailOptions = {
      from: `"Nyasa Technologies" <${process.env.EMAIL_USER}>`,
      to,  // ← This is the user's email from controller
      subject: "Verify your email address - Nyasa Technologies",
      html: htmlContent,
    };
    const info = await transporter.sendMail(mailOptions);
    console.log("Email sent to:", to, "| Message ID:", info.messageId);
    return info;
  } catch (error) {
    console.error("Email sending failed:", error);
    throw error;
  }
};

