// server/utils/smsService.js
import twilio from "twilio";
import dotenv from "dotenv";

dotenv.config();

const client = twilio(process.env.TWILIO_SID, process.env.TWILIO_AUTH_TOKEN);

export const sendVerificationSMS = async (to, otp) => {
  try {
    const message = await client.messages.create({
      body: `Your Nyasa Technologies verification code is: ${otp}`,
      from: process.env.TWILIO_PHONE_NUMBER, // Twilio verified number
      to, // e.g. '+911234567890'
    });

    console.log("✅ SMS sent to:", to, "| SID:", message.sid);
    return message;
  } catch (error) {
    console.error("❌ SMS sending failed:", error);
    throw error;
  }
};
