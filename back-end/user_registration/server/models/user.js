import mongoose from "mongoose";

const userSchema = new mongoose.Schema(
  {
    whoAmI: { type: String, required: true, trim: true },
    username: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
      trim: true,
      index: true, // keep this
    },
    firstName: { type: String, required: true, trim: true },
    lastName: { type: String, required: true, trim: true },
    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
      trim: true,
      match: [/\S+@\S+\.\S+/, "Invalid email format"],
      index: true, // keep this
    },
    mobileNo: {
      type: String,
      required: true,
      unique: true,
      trim: true,
      match: [/^\+?[0-9]{10,15}$/, "Invalid mobile number"],
      index: true, // keep this
    },
    password: { type: String, required: true },
    pinCode: { type: String, required: true, trim: true },
    date: { type: Date, default: Date.now },
    isMfaActive: { type: Boolean, default: false },
    twoFactorSecret: { type: String, default: "" },
    resetSecret: { type: String, default: "" },
    resetPasswordToken: { type: String, default: "" },
    resetPasswordExpires: { type: Date },
  },
  {
    timestamps: true,
  }
);

// ❌ remove these (duplicate)
// userSchema.index({ username: 1 }, { unique: true, sparse: true });
// userSchema.index({ email: 1 }, { unique: true, sparse: true });
// userSchema.index({ mobileNo: 1 }, { unique: true, sparse: true });

userSchema.on("index", (err) => {
  if (err) console.error("User index creation failed:", err);
  else console.log("✅ User indexes ensured successfully.");
});

const User = mongoose.model("User", userSchema);
export default User;
